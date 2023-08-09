#include <iostream>
#include <fstream>
#include <vector>
#include <regex>
#include <algorithm>
#include <cctype>
#include <unordered_map>
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./Compiler.hpp"

/******************************************
                SYMBOL TABLE
*******************************************/

SymbolTable::SymbolTable(){
}

void SymbolTable::ClearTable(){
    table = {};
}

void SymbolTable::SetRow(std::string name, TableRow row){
    table.insert({name, row});
}

TableRow SymbolTable::GetRow(std::string name){
    return table[name];
}

void SymbolTable::define(std::string name, std::string type, std::string kind){
    TableRow row {name, type, kind, varCount(kind)};

    SetRow(name, row);
}

int SymbolTable::varCount(std::string kind){
    int count = 0;

    for (const auto& pair : table){
        if (pair.second.kind == kind){
            count ++;
        }
    }

    return count;
}

bool SymbolTable::NameIsType(std::string name){
    for(const auto& pair : table){
        if (pair.second.type == name){
            return true;
        }
    }

    return false;
}

void SymbolTable::printTable(){
    std::cout << "Printing table...." << std::endl;
    for(const auto& pair : table){
        std::cout << "var: " << pair.first << " type: " << pair.second.type << " kind: " << pair.second.kind << " index: " << pair.second.index << std::endl;
    }
}

std::string SymbolTable::kindOf(std::string name){
    return GetRow(name).kind;
}

std::string SymbolTable::typeOf(std::string name){
    return GetRow(name).type;
}


int SymbolTable::indexOf(std::string name){
    return GetRow(name).index;
}

bool SymbolTable::variableDefined(std::string name){
    for (const auto& pair : table){
        if (pair.first == name){
            return true;
        }
    }

    return false;
}

SymbolTable::~SymbolTable(){ }

/******************************************
                VM WRITER
*******************************************/

VMWriter::VMWriter(){
    ops["+"] = "add";
    ops["-"] = "sub";
    ops["/"] = "call Math.divide 2";
    ops[">"] = "gt";
    ops["<"] = "lt";
    ops["~"] = "not";
    ops["|"] = "or";
    ops["&"] = "and";
    ops["*"] = "call Math.multiply 2";
    ops["="] = "eq";
    ops["*-"] = "neg";
    ops["*~"] = "not";
}

VMWriter::~VMWriter(){}

std::string VMWriter::WritePush(std::string segment, int index){
    std::transform(segment.begin(), segment.end(), segment.begin(), [](unsigned char c) { return std::tolower(c); });

    return "push " + segment + " " + std::to_string(index);
}

std::string VMWriter::WritePop(std::string segment, int index){
    std::transform(segment.begin(), segment.end(), segment.begin(), [](unsigned char c) { return std::tolower(c); });

    return "pop " + segment + " " + std::to_string(index);
}

std::string VMWriter::WriteArithmetic(std::string command){
    return ops[command];
}

std::string VMWriter::WriteLabel(std::string label){
    return "label " + label;
}

std::string VMWriter::WriteGoto(std::string label){
    return "goto " + label;
}

std::string VMWriter::WriteIf(std::string label){
    return "if-goto " + label;
}

std::string VMWriter::WriteCall(std::string name, int nArgs){
    return "call " + name + " " + std::to_string(nArgs);
}

std::string VMWriter::WriteFunction(std::string name, int nLVars){
    return "function " + name + " " + std::to_string(nLVars);
}

std::string VMWriter::WriteReturn(){
    return "return";
}

/******************************************
                COMPILER
*******************************************/

Compiler::Compiler(){ }

Compiler::~Compiler(){ }

void Compiler::Compile(std::string output_path, Lexer lxr){
    std::ofstream outfile(output_path);
    
    lexer = lxr;
    CompileClass(outfile);

    std::cout << "Done compiling into: " << output_path << std::endl; 
}

bool Compiler::StartOfTerm(){
    return (lexer.GetTokenType() == "INT_CONST") || (lexer.GetTokenType() == "STRING_CONST") || (lexer.GetSpecificType(lexer.GetCurrentToken()) == "KEYWORD_CONST") ||
    ((lexer.GetTokenType() == "IDENTIFIER") && !(lexer.Peek() == "(" || lexer.Peek() == ".")) || (lexer.Peek() == "[") || (lexer.GetCurrentToken() == "(") || (lexer.GetCurrentToken() == "-" || lexer.GetCurrentToken() == "~") ||
    (lexer.Peek() == "(") || (lexer.Peek() == ".");
}

void Compiler::SaveSubroutine(std::string sub_nme, std::string sub_type){
    Subroutine sub{sub_nme, sub_type};
    subroutines.push_back(sub);
    currentSub = subroutines[subroutines.size() - 1];
}

bool Compiler::NameInSubs(std::string name){
    auto it = std::find_if(subroutines.begin(), subroutines.end(), [name](const Subroutine& sub){
        return sub.sub_name == name;
    });

    return it != subroutines.end();
}


std::string Compiler::SubKind(std::string sub_name){
    auto it = std::find_if(subroutines.begin(), subroutines.end(), [sub_name](const Subroutine& sub){
        return sub.sub_name == sub_name;
    });

    return it->sub_kind;
}

bool Compiler::NameInClasses(std::string name){
    auto it = std::find(classes.begin(), classes.end(), name);

    return it != classes.end();
}


void Compiler::CompileClass(std::ofstream& output_file){
    // initialise empty class level symbol table
    cLSymbolTable.ClearTable();

    Process("class", "", "");
    classes.push_back(Process("", "IDENTIFIER", ""));
    currentClass = classes[classes.size()-1];
    Process("{", "", "");
    // class variable declarations
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "CLASSVARDEC"){
        CompileClassVarDec(output_file); 
    }

    // subroutine declarations
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "SUBTYPE"){
        CompileSubroutine(output_file);
    }
    Process("}", "", "");

}

void Compiler::CompileClassVarDec(std::ofstream& output_file){
    std::string var_kind = Process(lexer.GetCurrentToken(), "", "CLASSVARDEC");
    std::string var_type = Process(lexer.GetCurrentToken(), "", "TYPE");
    std::string name = Process("", "IDENTIFIER", "");

    cLSymbolTable.define(name, var_type, var_kind);

    // variables of the same type
    while(lexer.GetCurrentToken() == ","){
        Process(",", "", "");
        name = Process("", "IDENTIFIER", "");

        cLSymbolTable.define(name, var_type, var_kind);
    }

    Process(";", "", "");
    // cLSymbolTable.printTable();
}

void Compiler::CompileSubroutine(std::ofstream& output_file){
    sLSymbolTable.ClearTable();
    cond_counter = 0;

    std::string subType = Process(lexer.GetCurrentToken(), "", "SUBTYPE");
    std::string subRetType = Process(lexer.GetCurrentToken(), "", "SUBRETTYPE");

    if (subType == "method"){
        /*
            first row in subroutine level symbol table is argument 0 for mmethods, the
            base address of object on which method acts is passed as the first argument by caller func
        */ 
        sLSymbolTable.define("this", currentClass, "arg");
    }
    
    Process("", "IDENTIFIER", "");
    SaveSubroutine(lexer.Previous(), subType);
    Process("(", "", "");
    // parameter list
    CompileParamList(output_file);
    Process(")", "", "");

    // pass additional code in CompileSubroutineBody, where function body will be constructed
    std::string additionalCode = "";
    
    if (subType == "constructor"){
        additionalCode = vmwriter.WritePush("constant", cLSymbolTable.varCount("field")) + "\n" + vmwriter.WriteCall("Memory.alloc", 1) + "\n" + vmwriter.WritePop("pointer", 0);
    } else if (subType == "method"){
        additionalCode = vmwriter.WritePush("argument", 0) + "\n" + vmwriter.WritePop("pointer", 0);
    }

    CompileSubroutineBody(output_file, additionalCode);
    
    if (subType == "constructor"){
        output_file << vmwriter.WritePush("pointer", 0) << std::endl;
    }
    
    if (subRetType == "void"){
        output_file << vmwriter.WritePush("constant", 0) << std::endl;
    }

    output_file << vmwriter.WriteReturn() << std::endl;
}

void Compiler::CompileParamList(std::ofstream& output_file){

    // check that the subroutine has at least one parameter
    if(lexer.GetSpecificType(lexer.GetCurrentToken()) == "TYPE"){
        std::string param_type = Process(lexer.GetCurrentToken(), "", "TYPE");
        std::string param_name = Process("", "IDENTIFIER", "");

        sLSymbolTable.define(param_name, param_type, "arg");
        // more paramters
        while(lexer.GetCurrentToken() == ","){
            Process(",", "", "");
            param_type = Process(lexer.GetCurrentToken(), "", "TYPE");
            param_name = Process("", "IDENTIFIER", "");

            sLSymbolTable.define(param_name, param_type, "arg");
        }
    }

}

int Compiler::CompileVarDec(std::ofstream& output_file){
    int nVarDecs = 0;

    Process("var", "", "");
    std::string var_type = Process(lexer.GetCurrentToken(), "", "TYPE");
    std::string var_name = Process("", "IDENTIFIER", "");

    sLSymbolTable.define(var_name, var_type, "var");

    nVarDecs = 1;

    // variables of the same type
    while(lexer.GetCurrentToken() == ","){
        Process(",", "", "");
        var_name = Process("", "IDENTIFIER", "");

        sLSymbolTable.define(var_name, var_type, "var");

        nVarDecs += 1;
    }
    Process(";", "", "");
    
    return nVarDecs;
}

void Compiler::CompileSubroutineBody(std::ofstream& output_file, std::string additionalCode){
    Process("{", "", "");

    int nVarDecs = 0;
    // subroutine variable declarations
    while(lexer.GetCurrentToken() == "var"){
        nVarDecs += CompileVarDec(output_file);
    }

    // sLSymbolTable.printTable();

    output_file << vmwriter.WriteFunction(currentClass + "." + currentSub.sub_name, nVarDecs) << std::endl;
    if (additionalCode != ""){ output_file << additionalCode << std::endl; }

    // statements
    CompileStatements(output_file);
    
    Process("}", "", "");
}

void Compiler::CompileStatements(std::ofstream& output_file){
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "STATEMENT"){
        if(lexer.GetCurrentToken() == "let"){
            CompileLet(output_file);
        } else if (lexer.GetCurrentToken() == "if"){
            CompileIf(output_file);
            cond_counter += 1;
        } else if (lexer.GetCurrentToken() == "while"){
            CompileWhile(output_file);
            cond_counter += 1;

        } else if (lexer.GetCurrentToken() == "do"){
            CompileDo(output_file);
        } else if(lexer.GetCurrentToken() == "return"){
            CompileReturn(output_file);
        } 
    }
}

void Compiler::CompileTerm(std::ofstream& output_file){
    if (lexer.GetTokenType() == "INT_CONST"){

        std::string int_const = Process("", "INT_CONST", "");
        output_file << vmwriter.WritePush("constant", std::stoi(int_const)) << std::endl;

    } else if (lexer.GetTokenType() == "STRING_CONST"){

        std::string str_const = Process("", "STRING_CONST", "");

        output_file << vmwriter.WritePush("constant", str_const.size()-2) << std::endl;
        output_file << vmwriter.WriteCall("String.new", 1) << std::endl;

        for (int i = 1; i < str_const.size()-1; i++){
            output_file << vmwriter.WritePush("constant", (int)str_const[i]) << std::endl;
            output_file << vmwriter.WriteCall("String.appendChar", 2) << std::endl;
        }

    } else if (lexer.GetSpecificType(lexer.GetCurrentToken()) == "KEYWORD_CONST"){

        std::string keyword_const = Process(lexer.GetCurrentToken(), "", "KEYWORD_CONST");

        if (keyword_const == "null" || keyword_const == "false"){
            output_file << vmwriter.WritePush("constant", 0) << std::endl;
        } else if (keyword_const == "this"){
            output_file << vmwriter.WritePush("pointer", 0) << std::endl;
        } else {
            output_file << vmwriter.WritePush("constant", 0) << std::endl;
            output_file << vmwriter.WriteArithmetic("~") << std::endl;
        }

    } else if ((lexer.GetTokenType() == "IDENTIFIER") && !(lexer.Peek() == "(" || lexer.Peek() == "." || lexer.Peek() == "[")){
        // not sure what to do for pure identifiers 
        std::string identifier = Process("", "IDENTIFIER", "");

        // search symbol tables for idenitfier
        std::string seg;
        int index;

        if (sLSymbolTable.variableDefined(identifier)){
            seg = sLSymbolTable.kindOf(identifier) == "var" ? "local" : "argument";
            index = sLSymbolTable.indexOf(identifier);
        } else {
            if (cLSymbolTable.variableDefined(identifier)){
                seg = cLSymbolTable.kindOf(identifier) == "field" ? "this" : "static";
                index = cLSymbolTable.indexOf(identifier);
            } else {
                output_file << "Syntax error: Variable " << identifier << " not defined" << std::endl;
            }
        }

        output_file << vmwriter.WritePush(seg, index) << std::endl;

    } else if (lexer.Peek() == "["){
        std::string identifier = Process("", "IDENTIFIER", "");

        // search symbol tables for idenitfier
        std::string seg;
        int index;
        
        if (sLSymbolTable.variableDefined(identifier)){
            seg = sLSymbolTable.kindOf(identifier) == "var" ? "local" : "argument";
            index = sLSymbolTable.indexOf(identifier);
        } else {
            if (cLSymbolTable.variableDefined(identifier)){
                seg = cLSymbolTable.kindOf(identifier) == "field" ? "this" : "static";
                index = cLSymbolTable.indexOf(identifier);
            } else {
                output_file << "Syntax error: Variable " << identifier << " not defined" << std::endl;
            }
        }

        Process("[", "", "");
        CompileExpression(output_file);
        Process("]", "", "");

        output_file << vmwriter.WritePush(seg, index) << std::endl;

        output_file << vmwriter.WriteArithmetic("+") << std::endl;

        output_file << vmwriter.WritePop("pointer", 1) << std::endl;
        output_file << vmwriter.WritePush("that", 0) << std::endl;
        
        
    } else if (lexer.GetCurrentToken() == "("){
        Process("(", "", "");
        CompileExpression(output_file);
        Process(")", "", "");

    } else if (lexer.GetCurrentToken() == "-" || lexer.GetCurrentToken() == "~"){
        std::string unary_op = Process(lexer.GetCurrentToken(), "", "");
    
        CompileTerm(output_file);

        output_file << vmwriter.WriteArithmetic("*" + unary_op) << std::endl;

    } else if (lexer.Peek() == "(" || lexer.Peek() == "."){
        // subroutine call is term
        // std::cout << lexer.GetCurrentToken();
        CompileSubroutineCall(output_file);

    } else {
        output_file << "Syntax error: Incorrect term" << std::endl;
    }
}


void Compiler::CompileExpression(std::ofstream& output_file){
    // there's at least one term in an expression
    CompileTerm(output_file);
    
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "OPERATOR"){
        std::string op = Process(lexer.GetCurrentToken(), "", "OPERATOR");
        CompileTerm(output_file);

        output_file << vmwriter.WriteArithmetic(op) << std::endl;
    }

}


int Compiler::CompileExpressionList(std::ofstream& output_file){
    int expressions = 0;

    if (StartOfTerm()){
        // there's at least one expression if true
        CompileExpression(output_file);

        expressions = 1;

        while(lexer.GetCurrentToken() == ","){
            expressions += 1;
            Process(",", "", "");
            CompileExpression(output_file);
        }
    }

    return expressions;
}

void Compiler::CompileSubroutineCall(std::ofstream& output_file){
    if(lexer.Peek() == "."){
    // calling subroutine from object
        if(NameInSubs(lexer.GetCurrentToken())){
            output_file << "Syntax error: Trying to access subroutine from subroutine using '.' is not allowed" << std::endl;
    
        } else {
            std::string identifier = Process("", "IDENTIFIER", "");
            
            // OS class identifiers not allowed, and if identifier at this point is a declared type in 
            if (!NameInClasses(identifier)){

                // search symbol tables for idenitfier
                std::string seg;
                int index;

                std::string identifier_loc;

                if (sLSymbolTable.variableDefined(identifier)){
                    seg = sLSymbolTable.kindOf(identifier) == "var" ? "local" : "argument";
                    index = sLSymbolTable.indexOf(identifier);
                    identifier_loc = "sub";
                } else {
                    if (cLSymbolTable.variableDefined(identifier)){
                        seg = cLSymbolTable.kindOf(identifier) == "field" ? "this" : "static";
                        index = cLSymbolTable.indexOf(identifier);
                        identifier_loc = "class";
                    } else {
                        output_file << "Syntax error: Variable " << identifier << " not defined" << std::endl;
                    }
                }
                // push symbol table mapping of varName onto stack
                output_file << vmwriter.WritePush(seg, index) << std::endl;

                Process(".", "", "");
                std::string sub_name = Process("", "IDENTIFIER", "");

                //if (SubKind(sub_name) != "method"){
                //    output_file << "Syntax error: Functions should be referenced with class names" << std::endl;
                //} else {
                Process("(", "", "");
                int nArgs = CompileExpressionList(output_file);
                Process(")", "", "");
                
                std::string class_name = (identifier_loc == "sub")? sLSymbolTable.typeOf(identifier) : cLSymbolTable.typeOf(identifier);
                output_file << vmwriter.WriteCall(class_name  + "." + sub_name, nArgs + 1) << std::endl;
                //}
                    

            } else {

                Process(".", "", "");
                std::string method_name = Process("", "IDENTIFIER", "");
                Process("(", "", "");
                int nArgs = CompileExpressionList(output_file);
                Process(")", "", "");

                output_file << vmwriter.WriteCall(identifier + "." + method_name, nArgs) << std::endl;
            }
        }
    
    } else {
        // no varName given, so push symbol table mapping of the this pointer (the current object)
        
        output_file << vmwriter.WritePush("pointer", 0) << std::endl;

        std::string method_name = Process("", "IDENTIFIER", "");
        Process("(", "", "");
        int nArgs = CompileExpressionList(output_file);
        Process(")", "", "");

        output_file << vmwriter.WriteCall(currentClass + "." + method_name, nArgs + 1) << std::endl;
    }
};

void Compiler::CompileLet(std::ofstream& output_file){

    Process("let", "", "");
    std::string identifier = Process("", "IDENTIFIER", "");
    std::string seg = "";
    int index;

    if (sLSymbolTable.variableDefined(identifier)){
        seg = sLSymbolTable.kindOf(identifier) == "var" ? "local" : "argument";
        index = sLSymbolTable.indexOf(identifier);
    } else {
        if (cLSymbolTable.variableDefined(identifier)){
            seg = cLSymbolTable.kindOf(identifier) == "field" ? "this" : "static";
            index = cLSymbolTable.indexOf(identifier);
        } else {
            output_file << "Syntax error: Variable " << identifier << " not defined" << std::endl;
        }
    }
    
    // list access?
    if(lexer.GetCurrentToken() == "["){
        Process("[", "", "");
        CompileExpression(output_file);
        Process("]", "", "");
        output_file << vmwriter.WritePush(seg, index) << std::endl;

        output_file << vmwriter.WriteArithmetic("+") << std::endl;

        Process("=", "", "");
        CompileExpression(output_file);
        output_file << vmwriter.WritePop("temp", 0) << std::endl;
        output_file << vmwriter.WritePop("pointer", 1) << std::endl;
        output_file << vmwriter.WritePush("temp", 0) << std::endl;
        output_file << vmwriter.WritePop("that", 0) << std::endl;
    } else {
        Process("=", "", "");
        CompileExpression(output_file);

        output_file << vmwriter.WritePop(seg, index) << std::endl;
    }

    Process(";", "", "");
}

void Compiler::CompileDo(std::ofstream& output_file){
    Process("do", "", "");

    CompileSubroutineCall(output_file);

    output_file << vmwriter.WritePop("temp", 0) << std::endl;

    Process(";", "", "");
}

void Compiler::CompileIf(std::ofstream& output_file){
    Process("if", "", "");
    Process("(", "", "");
    CompileExpression(output_file);

    output_file << vmwriter.WriteArithmetic("~") << std::endl;
    output_file << vmwriter.WriteIf("FALSE" + std::to_string(cond_counter)) << std::endl;

    Process(")", "", "");
    Process("{", "", "");
    CompileStatements(output_file);
    Process("}", "", "");

    output_file << vmwriter.WriteGoto("COND_END" + std::to_string(cond_counter)) << std::endl;
    output_file << vmwriter.WriteLabel("FALSE" + std::to_string(cond_counter)) << std::endl;

    if(lexer.GetCurrentToken() == "else"){
        Process("else", "", "");
        Process("{", "", "");
        CompileStatements(output_file);
        Process("}", "", "");
    }

    output_file << vmwriter.WriteLabel("COND_END" + std::to_string(cond_counter)) << std::endl;
}

void Compiler::CompileWhile(std::ofstream& output_file){
    output_file << vmwriter.WriteLabel("LOOP_START" + std::to_string(cond_counter)) << std::endl;

    Process("while", "", "");
    Process("(", "", "");
    CompileExpression(output_file);

    output_file << vmwriter.WriteArithmetic("~") << std::endl;

    Process(")", "", "");
    output_file << vmwriter.WriteIf("LOOP_END" + std::to_string(cond_counter)) << std::endl;
    Process("{", "", "");
    CompileStatements(output_file);

    output_file << vmwriter.WriteGoto("LOOP_START" + std::to_string(cond_counter)) << std::endl;
    Process("}", "", "");
    
    output_file << vmwriter.WriteLabel("LOOP_END" + std::to_string(cond_counter)) << std::endl;
}

void Compiler::CompileReturn(std::ofstream& output_file){
    Process("return", "", "");

    if(lexer.GetCurrentToken() != ";"){
        CompileExpression(output_file);
    }

    Process(";", "", "");
}

std::string Compiler::Process(std::string str, std::string tkn_type, std::string specific_type){
    if (lexer.GetCurrentToken() == str || lexer.GetTokenType() == tkn_type || lexer.GetSpecificType(str) == specific_type){
        std::string token = lexer.GetCurrentToken(); 
        if (lexer.HasMoreTokens()) {lexer.Advance();}
        return token;
        
    } else {
        return "Syntax error";
    }
}


