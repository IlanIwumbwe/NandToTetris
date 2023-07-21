#pragma once
#include <string>
#include <vector>

class Tokeniser{
    public:
        Tokeniser();
        void SetFilePath(std::string current_path);
        void GetTokens();
        bool HasMoreTokens();
        void Advance();
        std::string GetCurrentToken();
        std::string GetTokenType();

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

        // all tokens
        std::vector<std::string> tokens;
        int token_pointer;


};