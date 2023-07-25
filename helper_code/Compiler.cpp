#include <iostream>
#include <fstream>
#include <vector>
#include <regex>
#include <algorithm>
#include <map>
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./Compiler.hpp"

Compiler::Compiler(){

}

void Compiler::SetTokeniser(Tokeniser tk){
    tokeniser = tk;
}

void Compiler::SaveSubName(std::string sub_nme){
    subroutine_names.push_back(sub_nme);
}

bool Compiler::NameInSubs(std::string name){
    auto it = std::find(subroutine_names.begin(), subroutine_names.end(), name);

    return it != subroutine_names.end();
}

void Compiler::CompileSubroutineCall(std::ofstream& output_file){
    if(tokeniser.Peek() == "."){
    // calling subroutine from object
        if(NameInSubs(tokeniser.GetCurrentToken())){
            output_file << "Syntax error: Trying to access subroutine from subroutine using '.' is not allowed" << std::endl;
        } else {
            output_file << Process("", "IDENTIFIER", "") << std::endl;
            output_file << Process(".", "", "") << std::endl;
            output_file << Process("", "IDENTIFIER", "") << std::endl;
            output_file << Process("(", "", "") << std::endl;
            CompileExpressionList(output_file);
            output_file << Process(")", "", "") << std::endl;
        }
    
    } else {
        output_file << Process("", "IDENTIFIER", "") << std::endl;
        output_file << Process("(", "", "") << std::endl;
        CompileExpressionList(output_file);
        output_file << Process(")", "", "") << std::endl;
    }
};

bool Compiler::StartOfTerm(){
    return (tokeniser.GetTokenType() == "INT_CONST") || (tokeniser.GetTokenType() == "STRING_CONST") || (tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "KEYWORD_CONST") ||
    ((tokeniser.GetTokenType() == "IDENTIFIER") && !(tokeniser.Peek() == "(" || tokeniser.Peek() == ".")) || (tokeniser.Peek() == "[") || (tokeniser.GetCurrentToken() == "(") || (tokeniser.GetCurrentToken() == "-" || tokeniser.GetCurrentToken() == "~") ||
    (tokeniser.Peek() == "(") || (tokeniser.Peek() == ".");
}

void Compiler::CompileTerm(std::ofstream& output_file){
    output_file << "<term>" << std::endl;
    if (tokeniser.GetTokenType() == "INT_CONST"){
        output_file << Process("", "INT_CONST", "") << std::endl;
    } else if (tokeniser.GetTokenType() == "STRING_CONST"){
        output_file << Process("", "STRING_CONST", "") << std::endl;
    } else if (tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "KEYWORD_CONST"){
        output_file << Process(tokeniser.GetCurrentToken(), "", "KEYWORD_CONST") << std::endl;
    } else if ((tokeniser.GetTokenType() == "IDENTIFIER") && !(tokeniser.Peek() == "(" || tokeniser.Peek() == "." || tokeniser.Peek() == "[")){
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    } else if (tokeniser.Peek() == "["){
        output_file << Process("", "IDENTIFIER", "") << std::endl;
        output_file << Process("[", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process("]", "", "") << std::endl;
    } else if (tokeniser.GetCurrentToken() == "("){
        output_file << Process("(", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process(")", "", "") << std::endl;
    } else if (tokeniser.GetCurrentToken() == "-" || tokeniser.GetCurrentToken() == "~"){
        std::cout << tokeniser.GetCurrentToken() << "-" << tokeniser.GetTokenType();
        output_file << Process(tokeniser.GetCurrentToken(), "", "") << std::endl;
        CompileTerm(output_file);
    } else if (tokeniser.Peek() == "(" || tokeniser.Peek() == "."){
        // subroutine call is term
        CompileSubroutineCall(output_file);
    } else {
        output_file << "Syntax error: Incorrect term" << std::endl;
    }
    output_file << "</term>" << std::endl;
}

void Compiler::Compile(std::string output_path){
    std::ofstream outfile(output_path);

    CompileClass(outfile);

    std::cout << "Done compiling into: " << output_path << std::endl; 
}

void Compiler::CompileClass(std::ofstream& output_file){
    output_file << "<class>" << std::endl;
    output_file << Process("class", "", "") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    output_file << Process("{", "", "") << std::endl;
    // class variable declarations
    while(tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "CLASSVARDEC"){
        CompileClassVarDec(output_file);
    }

    // subroutine declarations
    while(tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "SUBTYPE"){
        CompileSubroutine(output_file);
    }
    output_file << Process("}", "", "") << std::endl;
    output_file << "</class>" << std::endl;

}

void Compiler::CompileClassVarDec(std::ofstream& output_file){
    output_file << "<classVarDec>" << std::endl;
    output_file << Process(tokeniser.GetCurrentToken(), "", "CLASSVARDEC") << std::endl;
    output_file << Process(tokeniser.GetCurrentToken(), "", "TYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    // variables of the same type
    while(tokeniser.GetCurrentToken() == ","){
        output_file << Process(",", "", "") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    }
    output_file << Process(";", "", "") << std::endl;
    output_file << "</classVarDec>" << std::endl;
}

void Compiler::CompileSubroutine(std::ofstream& output_file){
    output_file << "<subroutineDec>" << std::endl;
    output_file << Process(tokeniser.GetCurrentToken(), "", "SUBTYPE") << std::endl;
    output_file << Process(tokeniser.GetCurrentToken(), "", "SUBRETTYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    SaveSubName(tokeniser.Previous());
    output_file << Process("(", "", "") << std::endl;
    // parameter list
    CompileParamList(output_file);
    output_file << Process(")", "", "") << std::endl;
    CompileSubroutineBody(output_file);
    output_file << "</subroutineDec>" << std::endl;
}

void Compiler::CompileParamList(std::ofstream& output_file){
    output_file << "<parameterList>" << std::endl;

    // check that the subroutine has at least one parameter
    if(tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "TYPE"){
        output_file << Process(tokeniser.GetCurrentToken(), "", "TYPE") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;

        // more paramters
        while(tokeniser.GetCurrentToken() == ","){
            output_file << Process(",", "", "") << std::endl;
            output_file << Process(tokeniser.GetCurrentToken(), "", "TYPE") << std::endl;
            output_file << Process("", "IDENTIFIER", "") << std::endl;
        }
    }

    output_file << "</parameterList>" << std::endl; 
}

void Compiler::CompileSubroutineBody(std::ofstream& output_file){
    output_file << "<subroutineBody>" << std::endl;
    output_file << Process("{", "", "") << std::endl;

    // subroutine variable declarations
    while(tokeniser.GetCurrentToken() == "var"){
        CompileVarDec(output_file);
    }

    // statements
    CompileStatements(output_file);
    
    output_file << Process("}", "", "") << std::endl;

    output_file << "</subroutineBody>" << std::endl; 
}

void Compiler::CompileStatements(std::ofstream& output_file){
    output_file << "<statements>" << std::endl;
    while(tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "STATEMENT"){
        if(tokeniser.GetCurrentToken() == "let"){
            CompileLet(output_file);
        } else if (tokeniser.GetCurrentToken() == "if"){
            CompileIf(output_file);
        } else if (tokeniser.GetCurrentToken() == "while"){
            CompileWhile(output_file);
        } else if (tokeniser.GetCurrentToken() == "do"){
            CompileDo(output_file);
        } else if(tokeniser.GetCurrentToken() == "return"){
            CompileReturn(output_file);
        } 
    }
    output_file << "</statements>" << std::endl;
}

void Compiler::CompileExpression(std::ofstream& output_file){
    output_file << "<expression>" << std::endl;
    //std::cout << "curr:" << tokeniser.GetCurrentToken() << "nxt:" << tokeniser.Peek() << std::endl;
    // there's at least one term in an expression
    CompileTerm(output_file);

    

    while(tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) == "OPERATOR"){
        output_file << Process(tokeniser.GetCurrentToken(), "", "OPERATOR") << std::endl;
        CompileTerm(output_file);
    }

    output_file << "</expression>" << std::endl;
}

int Compiler::CompileExpressionList(std::ofstream& output_file){
    int expressions = 0;
    output_file << "<expressionList>" << std::endl;

    std::cout << tokeniser.GetSpecificType(tokeniser.GetCurrentToken()) << std::endl;

    if (StartOfTerm()){
        // there's at least one expression if true
        CompileExpression(output_file);

        expressions = 1;

        while(tokeniser.GetCurrentToken() == ","){
            expressions += 1;
            output_file << Process(",", "", "") << std::endl;
            CompileExpression(output_file);
        }
    }

    output_file << "</expressionList>" << std::endl;

    return expressions;
}

void Compiler::CompileLet(std::ofstream& output_file){
    output_file << "<letStatement>" << std::endl;
    output_file << Process("let", "", "") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    
    // list access?
    if(tokeniser.GetCurrentToken() == "["){
        output_file << Process("[", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process("]", "", "") << std::endl;
    }

    output_file << Process("=", "", "") << std::endl;
    CompileExpression(output_file);
    output_file << Process(";", "", "") << std::endl;
    output_file << "</letStatement>" << std::endl;
}

void Compiler::CompileIf(std::ofstream& output_file){
    output_file << "<ifStatement>" << std::endl;
    output_file << Process("if", "", "") << std::endl;
    output_file << Process("(", "", "") << std::endl;
    CompileExpression(output_file);
    output_file << Process(")", "", "") << std::endl;
    output_file << Process("{", "", "") << std::endl;
    CompileStatements(output_file);
    output_file << Process("}", "", "") << std::endl;

    if(tokeniser.GetCurrentToken() == "else"){
        output_file << Process("else", "", "") << std::endl;
        output_file << Process("{", "", "") << std::endl;
        CompileStatements(output_file);
        output_file << Process("}", "", "") << std::endl;
    }
    output_file << "</ifStatement>" << std::endl;
}

void Compiler::CompileWhile(std::ofstream& output_file){
    output_file << "<whileStatement>" << std::endl;
    output_file << Process("while", "", "") << std::endl;
    output_file << Process("(", "", "") << std::endl;
    CompileExpression(output_file);
    output_file << Process(")", "", "") << std::endl;
    output_file << Process("{", "", "") << std::endl;
    CompileStatements(output_file);
    output_file << Process("}", "", "") << std::endl;
    output_file << "</whileStatement>" << std::endl;
}

void Compiler::CompileDo(std::ofstream& output_file){
    output_file << "<doStatement>" << std::endl;
    output_file << Process("do", "", "") << std::endl;

    CompileSubroutineCall(output_file);

    output_file << Process(";", "", "") << std::endl;
    output_file << "</doStatement>" << std::endl;
}

void Compiler::CompileReturn(std::ofstream& output_file){
    output_file << "<returnStatement>" << std::endl;
    output_file << Process("return", "", "") << std::endl;

    if(tokeniser.GetCurrentToken() != ";"){
        CompileExpression(output_file);
    }

    output_file << Process(";", "", "") << std::endl;
    output_file << "</returnStatement>" << std::endl;
}

void Compiler::CompileVarDec(std::ofstream& output_file){
    output_file << "<varDec>" << std::endl;
    output_file << Process("var", "", "") << std::endl;
    output_file << Process(tokeniser.GetCurrentToken(), "", "TYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;

    // variables of the same type
    while(tokeniser.GetCurrentToken() == ","){
        output_file << Process(",", "", "") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    }
    output_file << Process(";", "", "") << std::endl;
    output_file << "</varDec>" << std::endl;
}

std::string Compiler::Process(std::string str, std::string tkn_type, std::string specific_type){
    if (tokeniser.GetCurrentToken() == str || tokeniser.GetTokenType() == tkn_type || tokeniser.GetSpecificType(str) == specific_type){
        std::string xml = GetTokenXML(tokeniser.GetCurrentToken(), tokeniser.GetTokenType());
        if (tokeniser.HasMoreTokens()) {tokeniser.Advance();}
        return xml;
    } else {
        return "Syntax error";
    }
}
