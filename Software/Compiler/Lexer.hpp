#pragma once
#include <string>
#include <vector>
#include <map>

class Lexer{
    public:
        Lexer();
        void SetFilePath(std::string current_path);
        void Lex();
        std::vector<std::string> GetTokens();
        bool HasMoreTokens();
        void Advance();
        std::string Peek();
        std::string Previous();
        std::string GetCurrentToken();
        std::string GetTokenType();
        std::string GetSpecificType(std::string tkn);
        void SaveTokens(std::string input_path);
        void InitialiseCurrToken();
        ~Lexer();

    private:
        std::string current_file_path;
        std::string current_token;
        bool ignore;

        // regular expressions for the Jack Grammer
        std::string keywords;
        std::string symbols;
        std::string int_constants;
        std::string string_constants;
        std::string identifiers;

        // additional patterns
        std::string classVarDec;
        std::string type;
        std::string subType;
        std::string subRetType;
        std::string keywordConst;
        std::string statements;
        std::string operators;
        std::string unary_ops;

        // all tokens
        std::vector<std::string> tokens;
        int token_pointer;
        
};