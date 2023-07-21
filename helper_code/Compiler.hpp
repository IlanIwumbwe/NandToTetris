#pragma once
#include <iostream>
#include <string>

class Compiler{
    public:
        Compiler(std::string output_path);
        void CompileClass();
        void CompileClassVarDec();
        void CompileSubroutine();
        void CompileParamList();
        void CompileSubroutineBody();
        void CompileVarDec();
        void CompileStatements();
        void CompileLet();
        void CompileIf();
        void CompileWhile();
        void CompileDo();
        void CompileReturn();
        void CompileExpression();
        void CompileTerm();
        int CompileExpressionList();

    private:
        std::string output_file_path;

};