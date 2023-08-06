#pragma once
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <unordered_map>
#include "./Lexer.hpp"

/******************************************
                SYMBOL TABLE
*******************************************/
struct TableRow{
    std::string name;
    std::string type;
    std::string kind;
    int index;
};

class SymbolTable{
    public:
        SymbolTable();
        void ClearTable();
        void SetRow(std::string name, TableRow row);
        TableRow GetRow(std::string name);
        void define(std::string name, std::string type, std::string kind);
        int varCount(std::string kind);
        std::string kindOf(std::string name);
        std::string typeOf(std::string name);
        int indexOf(std::string name);
        bool variableDefined(std::string name);
        ~SymbolTable();

    private:
        std::unordered_map<std::string, TableRow> table;

};

/******************************************
                VM WRITER
*******************************************/

class VMWriter{
    public:
        VMWriter();
        std::string WritePush(std::string segment, int index);
        std::string WritePop(std::string segment, int index);
        std::string WriteArithmetic(std::string command);
        std::string WriteLabel(std::string label);
        std::string WriteGoto(std::string label);
        std::string WriteIf(std::string label);
        std::string WriteCall(std::string name, int nArgs);
        std::string WriteFunction(std::string name, int nLVars);
        std::string WriteReturn();
        ~VMWriter();
};

/******************************************
                COMPILER
*******************************************/

class Compiler{
    public:
        Compiler();
        void Compile(std::string output_path);
        std::string Process(std::string str, std::string tkn_type, std::string specific_type);
        void SetLexer(Lexer lexr);
        void SetSymbolTables(SymbolTable cl, SymbolTable sl);
        void SetVMWriter(VMWriter writer);
        void SaveSubName(std::string sub_name);
        bool NameInSubs(std::string name);
        bool StartOfTerm();
        void CompileClass(std::ofstream& output_file);
        void CompileClassVarDec(std::ofstream& output_file);
        void CompileSubroutine(std::ofstream& output_file);
        void CompileParamList(std::ofstream& output_file);
        void CompileSubroutineBody(std::ofstream& output_file, std::string additionalCode);
        int CompileVarDec(std::ofstream& output_file);
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
        ~Compiler();

    private:
        Lexer lexer;
        std::vector<std::string> subroutine_names;
        SymbolTable cLSymbolTable;
        SymbolTable sLSymbolTable;
        VMWriter vmwriter;
        std::string currentClass;
        int cond_counter = 0;
};

