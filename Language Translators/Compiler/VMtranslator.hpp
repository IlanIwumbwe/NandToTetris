#pragma once
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <regex>
#include <map>
#include <sstream>
#include "./helper_funcs.hpp"

class Parser{
    public:
        Parser();
        void setCurrentCommand(std::string command);
        std::vector<std::string> Parse(std::string current_file_path);
        std::string commandType();
        std::string Arg1();
        std::string Arg2();

    private:
        std::string curr_command;
};

class CodeWriter{
    public:
        CodeWriter();
        void SetFilePath(std::string current_path);
        std::string WriteBootstrapCode();
        std::string WriteArithmetic(const std::string command, const int command_index);
        std::string WritePushPop(const std::string command, const std::string segment, const std::string index);
        std::string WriteLabel(std::string label);
        std::string WriteGoTo(std::string label);
        std::string WriteIfGoTo(std::string label);
        std::string WriteFunction(std::string functionName, std::string nLVars);
        std::string WriteCall(std::string functionName, std::string nArgs);
        std::string WriteReturn();
        std::string WriteEndLoop();

    private:
        std::string current_file_path;
        std::string current_function;
        std::map<std::string, int> calls;

        std::map<std::string, std::string> OPS;
    
        std::vector<std::string> pointers;

        std::string pushToStack;

        // R13 is used to store address to which data from stack should be popped
        std::string popFromStack;
};

class VMtranslator{
    public:
        VMtranslator();
        void Translate(std::vector<std::string> file_paths, std::ofstream &output_file);
        void run();

    private:
        Parser parser;
        CodeWriter codewriter;
};
