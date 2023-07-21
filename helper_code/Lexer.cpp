#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <regex>
#include "./helper_funcs.hpp"
#include "./Lexer.hpp"

Tokeniser::Tokeniser(){
    
    // regex for the Jack Grammar
    keywords = R"(class|int|constructor|function|method|field|static|var|char|boolean|void|true|false|null|this|let|do|if|else|while|return)";
    symbols = R"(\{|\}|\(|\)|\[|\]|\.|,|;|\+|-|\*|\/|&|\||<|>|=|~)";
    int_constants = R"([0-32767])";
    string_constants = R"("[^\n\"]+")";
    identifiers = R"([a-zA-Z_]\w*)";
    
    // variable instantiation
    ignore = false;

    current_file_path = "";
    current_token = "";
    token_pointer = 0;

}

void Tokeniser::SetFilePath(std::string current_path){
    current_file_path = current_path;
}

void Tokeniser::GetTokens(){
    std::ifstream infile;
    infile.open(current_file_path);

    std::vector<std::string> instructions;

    if (!infile.is_open())
    {
        std::cout << "Error while opening file..." << std::endl;
    }

    std::string line;

    while (std::getline(infile, line))
    {   
        // each line read has no newline character

        if (line.size() != 0){
            if ((line.find("/**") != std::string::npos) || (line.find("/*") != std::string::npos)) {
                ignore = (line.find("*/") == std::string::npos);
            } else if (line.find("*/") != std::string::npos){
                ignore = false;
            } else if ((line.find("//") != std::string::npos) && (line.find("//") != 0 && ignore != true)) {
                // comment in line
                std::vector<std::string> parts = splitString(line, "//");
                            
                instructions.push_back(removeWhiteSpace(parts[0]));
        
            } else if (line.find("//") == std::string::npos && ignore != true) {
                // no comment in line
                instructions.push_back(removeWhiteSpace(line));
            } 
        }
    }
    
    for (auto ins : instructions){
        ins = removeWhiteSpace(ins);
        // std::cout << "INS----------------:" << ins << std::endl;

        std::regex full_regex(identifiers + "|" + keywords + "|" + string_constants + "|" + symbols + "|" + int_constants);
        
        std::sregex_iterator iter(ins.begin(), ins.end(), full_regex);
        std::sregex_iterator end;

        for(; iter != end; ++iter){
            std::smatch match = *iter;
            tokens.push_back(match.str());
            // std::cout << match.str() << std::endl;
        }
        
    }

}

bool Tokeniser::HasMoreTokens(){
    return (tokens.size() != token_pointer);
}

void Tokeniser::Advance(){
    current_token = tokens[token_pointer++];
}

std::string Tokeniser::GetCurrentToken(){
    return current_token;
}

std::string Tokeniser::GetTokenType(){
    std::regex keyword_pattern(keywords);
    std::regex symbol_pattern(symbols);
    std::regex int_const_pattern(int_constants);
    std::regex str_const_pattern(string_constants);
    std::regex id_pattern(identifiers);

    if (std::regex_match(current_token, keyword_pattern)){
        return "KEYWORD";
    } else if (std::regex_match(current_token, symbol_pattern)){
        return "SYMBOL";
    } else if (std::regex_match(current_token, int_const_pattern)){
        return "INT_CONST";
    } else if (std::regex_match(current_token, str_const_pattern)){
        return "STRING_CONST";
    } else if (std::regex_match(current_token, id_pattern)){
        return "IDENTIFIER";
    } else {
        return "Not in Jack Lexicon";
    }
}

