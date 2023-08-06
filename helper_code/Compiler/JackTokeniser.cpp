#include <iostream>
#include <fstream>
#include <vector>
#include <regex>
#include <algorithm>
#include <map>
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./JackTokeniser.hpp"

CompilerXML::CompilerXML(){

}

CompilerXML::~CompilerXML(){
    
}

void CompilerXML::SetLexer(Lexer lexr){
    lexer = lexr;
}

void CompilerXML::SaveSubName(std::string sub_nme){
    subroutine_names.push_back(sub_nme);
}

bool CompilerXML::NameInSubs(std::string name){
    auto it = std::find(subroutine_names.begin(), subroutine_names.end(), name);

    return it != subroutine_names.end();
}

void CompilerXML::CompileSubroutineCall(std::ofstream& output_file){
    if(lexer.Peek() == "."){
    // calling subroutine from object
        if(NameInSubs(lexer.GetCurrentToken())){
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

bool CompilerXML::StartOfTerm(){
    return (lexer.GetTokenType() == "INT_CONST") || (lexer.GetTokenType() == "STRING_CONST") || (lexer.GetSpecificType(lexer.GetCurrentToken()) == "KEYWORD_CONST") ||
    ((lexer.GetTokenType() == "IDENTIFIER") && !(lexer.Peek() == "(" || lexer.Peek() == ".")) || (lexer.Peek() == "[") || (lexer.GetCurrentToken() == "(") || (lexer.GetCurrentToken() == "-" || lexer.GetCurrentToken() == "~") ||
    (lexer.Peek() == "(") || (lexer.Peek() == ".");
}

void CompilerXML::CompileTerm(std::ofstream& output_file){
    output_file << "<term>" << std::endl;
    if (lexer.GetTokenType() == "INT_CONST"){
        output_file << Process("", "INT_CONST", "") << std::endl;
    } else if (lexer.GetTokenType() == "STRING_CONST"){
        output_file << Process("", "STRING_CONST", "") << std::endl;
    } else if (lexer.GetSpecificType(lexer.GetCurrentToken()) == "KEYWORD_CONST"){
        output_file << Process(lexer.GetCurrentToken(), "", "KEYWORD_CONST") << std::endl;
    } else if ((lexer.GetTokenType() == "IDENTIFIER") && !(lexer.Peek() == "(" || lexer.Peek() == "." || lexer.Peek() == "[")){
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    } else if (lexer.Peek() == "["){
        output_file << Process("", "IDENTIFIER", "") << std::endl;
        output_file << Process("[", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process("]", "", "") << std::endl;
    } else if (lexer.GetCurrentToken() == "("){
        output_file << Process("(", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process(")", "", "") << std::endl;
    } else if (lexer.GetCurrentToken() == "-" || lexer.GetCurrentToken() == "~"){
        output_file << Process(lexer.GetCurrentToken(), "", "") << std::endl;
        CompileTerm(output_file);
    } else if (lexer.Peek() == "(" || lexer.Peek() == "."){
        // subroutine call is term
        CompileSubroutineCall(output_file);
    } else {
        output_file << "Syntax error: Incorrect term" << std::endl;
    }
    output_file << "</term>" << std::endl;
}

void CompilerXML::Compile(std::string output_path){
    std::ofstream outfile(output_path);

    CompileClass(outfile);

    std::cout << "Done compiling into: " << output_path << std::endl; 
}

void CompilerXML::CompileClass(std::ofstream& output_file){
    output_file << "<class>" << std::endl;
    output_file << Process("class", "", "") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    output_file << Process("{", "", "") << std::endl;
    // class variable declarations
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "CLASSVARDEC"){
        CompileClassVarDec(output_file);
    }

    // subroutine declarations
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "SUBTYPE"){
        CompileSubroutine(output_file);
    }
    output_file << Process("}", "", "") << std::endl;
    output_file << "</class>" << std::endl;

}

void CompilerXML::CompileClassVarDec(std::ofstream& output_file){
    output_file << "<classVarDec>" << std::endl;
    output_file << Process(lexer.GetCurrentToken(), "", "CLASSVARDEC") << std::endl;
    output_file << Process(lexer.GetCurrentToken(), "", "TYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    // variables of the same type
    while(lexer.GetCurrentToken() == ","){
        output_file << Process(",", "", "") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    }
    output_file << Process(";", "", "") << std::endl;
    output_file << "</classVarDec>" << std::endl;
}

void CompilerXML::CompileSubroutine(std::ofstream& output_file){
    output_file << "<subroutineDec>" << std::endl;
    output_file << Process(lexer.GetCurrentToken(), "", "SUBTYPE") << std::endl;
    output_file << Process(lexer.GetCurrentToken(), "", "SUBRETTYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    SaveSubName(lexer.Previous());
    output_file << Process("(", "", "") << std::endl;
    // parameter list
    CompileParamList(output_file);
    output_file << Process(")", "", "") << std::endl;
    CompileSubroutineBody(output_file);
    output_file << "</subroutineDec>" << std::endl;
}

void CompilerXML::CompileParamList(std::ofstream& output_file){
    output_file << "<parameterList>" << std::endl;

    // check that the subroutine has at least one parameter
    if(lexer.GetSpecificType(lexer.GetCurrentToken()) == "TYPE"){
        output_file << Process(lexer.GetCurrentToken(), "", "TYPE") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;

        // more paramters
        while(lexer.GetCurrentToken() == ","){
            output_file << Process(",", "", "") << std::endl;
            output_file << Process(lexer.GetCurrentToken(), "", "TYPE") << std::endl;
            output_file << Process("", "IDENTIFIER", "") << std::endl;
        }
    }

    output_file << "</parameterList>" << std::endl; 
}

void CompilerXML::CompileSubroutineBody(std::ofstream& output_file){
    output_file << "<subroutineBody>" << std::endl;
    output_file << Process("{", "", "") << std::endl;

    // subroutine variable declarations
    while(lexer.GetCurrentToken() == "var"){
        CompileVarDec(output_file);
    }

    // statements
    CompileStatements(output_file);
    
    output_file << Process("}", "", "") << std::endl;

    output_file << "</subroutineBody>" << std::endl; 
}

void CompilerXML::CompileStatements(std::ofstream& output_file){
    output_file << "<statements>" << std::endl;
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "STATEMENT"){
        if(lexer.GetCurrentToken() == "let"){
            CompileLet(output_file);
        } else if (lexer.GetCurrentToken() == "if"){
            CompileIf(output_file);
        } else if (lexer.GetCurrentToken() == "while"){
            CompileWhile(output_file);
        } else if (lexer.GetCurrentToken() == "do"){
            CompileDo(output_file);
        } else if(lexer.GetCurrentToken() == "return"){
            CompileReturn(output_file);
        } 
    }
    output_file << "</statements>" << std::endl;
}

void CompilerXML::CompileExpression(std::ofstream& output_file){
    output_file << "<expression>" << std::endl;
    //std::cout << "curr:" << lexer.GetCurrentToken() << "nxt:" << lexer.Peek() << std::endl;
    // there's at least one term in an expression
    CompileTerm(output_file);

    
    while(lexer.GetSpecificType(lexer.GetCurrentToken()) == "OPERATOR"){
        output_file << Process(lexer.GetCurrentToken(), "", "OPERATOR") << std::endl;
        CompileTerm(output_file);
    }

    output_file << "</expression>" << std::endl;
}

int CompilerXML::CompileExpressionList(std::ofstream& output_file){
    int expressions = 0;
    output_file << "<expressionList>" << std::endl;

    if (StartOfTerm()){
        // there's at least one expression if true
        CompileExpression(output_file);

        expressions = 1;

        while(lexer.GetCurrentToken() == ","){
            expressions += 1;
            output_file << Process(",", "", "") << std::endl;
            CompileExpression(output_file);
        }
    }

    output_file << "</expressionList>" << std::endl;

    return expressions;
}

void CompilerXML::CompileLet(std::ofstream& output_file){
    output_file << "<letStatement>" << std::endl;
    output_file << Process("let", "", "") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;
    
    // list access?
    if(lexer.GetCurrentToken() == "["){
        output_file << Process("[", "", "") << std::endl;
        CompileExpression(output_file);
        output_file << Process("]", "", "") << std::endl;
    }

    output_file << Process("=", "", "") << std::endl;
    CompileExpression(output_file);
    output_file << Process(";", "", "") << std::endl;
    output_file << "</letStatement>" << std::endl;
}

void CompilerXML::CompileIf(std::ofstream& output_file){
    output_file << "<ifStatement>" << std::endl;
    output_file << Process("if", "", "") << std::endl;
    output_file << Process("(", "", "") << std::endl;
    CompileExpression(output_file);
    output_file << Process(")", "", "") << std::endl;
    output_file << Process("{", "", "") << std::endl;
    CompileStatements(output_file);
    output_file << Process("}", "", "") << std::endl;

    if(lexer.GetCurrentToken() == "else"){
        output_file << Process("else", "", "") << std::endl;
        output_file << Process("{", "", "") << std::endl;
        CompileStatements(output_file);
        output_file << Process("}", "", "") << std::endl;
    }
    output_file << "</ifStatement>" << std::endl;
}

void CompilerXML::CompileWhile(std::ofstream& output_file){
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

void CompilerXML::CompileDo(std::ofstream& output_file){
    output_file << "<doStatement>" << std::endl;
    output_file << Process("do", "", "") << std::endl;

    CompileSubroutineCall(output_file);

    output_file << Process(";", "", "") << std::endl;
    output_file << "</doStatement>" << std::endl;
}

void CompilerXML::CompileReturn(std::ofstream& output_file){
    output_file << "<returnStatement>" << std::endl;
    output_file << Process("return", "", "") << std::endl;

    if(lexer.GetCurrentToken() != ";"){
        CompileExpression(output_file);
    }

    output_file << Process(";", "", "") << std::endl;
    output_file << "</returnStatement>" << std::endl;
}

void CompilerXML::CompileVarDec(std::ofstream& output_file){
    output_file << "<varDec>" << std::endl;
    output_file << Process("var", "", "") << std::endl;
    output_file << Process(lexer.GetCurrentToken(), "", "TYPE") << std::endl;
    output_file << Process("", "IDENTIFIER", "") << std::endl;

    // variables of the same type
    while(lexer.GetCurrentToken() == ","){
        output_file << Process(",", "", "") << std::endl;
        output_file << Process("", "IDENTIFIER", "") << std::endl;
    }
    output_file << Process(";", "", "") << std::endl;
    output_file << "</varDec>" << std::endl;
}

std::string CompilerXML::Process(std::string str, std::string tkn_type, std::string specific_type){
    if (lexer.GetCurrentToken() == str || lexer.GetTokenType() == tkn_type || lexer.GetSpecificType(str) == specific_type){
        std::string xml = GetTokenXML(lexer.GetCurrentToken(), lexer.GetTokenType());
        if (lexer.HasMoreTokens()) {lexer.Advance();}
        return xml;
    } else {
        return "Syntax error";
    }
}
