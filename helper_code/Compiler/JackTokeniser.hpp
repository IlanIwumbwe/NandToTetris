#pragma once
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include "./Lexer.hpp"

class CompilerXML{
    public:
        CompilerXML();
        void Compile(std::string output_path);
        std::string Process(std::string str, std::string tkn_type, std::string specific_type);
        void SetTokeniser(Tokeniser tk);
        void SaveSubName(std::string sub_name);
        bool NameInSubs(std::string name);
        bool StartOfTerm();
        void CompileClass(std::ofstream& output_file);
        void CompileClassVarDec(std::ofstream& output_file);
        void CompileSubroutine(std::ofstream& output_file);
        void CompileParamList(std::ofstream& output_file);
        void CompileSubroutineBody(std::ofstream& output_file);
        void CompileVarDec(std::ofstream& output_file);
        void CompileStatements(std::ofstream& output_file);
        void CompileLet(std::ofstream& output_file);
        void CompileIf(std::ofstream& output_file);
        void CompileWhile(std::ofstream& output_file);
        void CompileDo(std::ofstream& output_file);
        void CompileReturn(std::ofstream& output_file);
        void CompileExpression(std::ofstream& output_file);
        void CompileTerm(std::ofstream& output_file);
        void CompileSubroutineCall(std::ofstream& output_file);
        int CompileExpressionList(std::ofstream& output_file);

    private:
        Tokeniser tokeniser;
        std::vector<std::string> subroutine_names;
};