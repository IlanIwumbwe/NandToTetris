#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <regex>
#include <map>
#include "./helper_funcs.hpp"
#include "./Lexer.hpp"

Tokeniser::Tokeniser(){
    
    // regex for the Jack Grammar
    keywords = R"(class|int|constructor|function|method|field|static|var|char|boolean|void|true|false|null|this|let|do|if|else|while|return)";
    symbols = R"(\{|\}|\(|\)|\[|\]|\.|,|;|\+|-|\*|\/|&|\||<|>|=|~)";
    int_constants = R"([0-9]+)";
    string_constants = R"("[^\n\"]+")";
    identifiers = R"([a-zA-Z_]\w*)";

    // additional patterns
    classVarDec = R"(static|field)";
    type = R"(int|char|boolean|)" + identifiers;
    subType = R"(constructor|function|method)";
    subRetType = R"(void|)" + type;
    keywordConst = R"(true|false|null|this)";
    statements = R"(let|if|while|do|return)";
    operators = R"(\+|-|\*|&|\||\/|<|>|=)";

    // variable instantiation
    ignore = false;

    current_file_path = "";
    token_pointer = 0;
    current_token = "";

}

void Tokeniser::SetFilePath(std::string current_path){
    current_file_path = current_path;
}

std::vector<std::string> Tokeniser::GetTokens(){
    return tokens;
}

std::string Tokeniser::Peek(){
    if (HasMoreTokens()) {
        return tokens[token_pointer + 1];
    } else {
        return "NULL";
    }
}

std::string Tokeniser::Previous(){
    return tokens[token_pointer - 1];
}


void Tokeniser::InitialiseCurrToken(){
    current_token = tokens[token_pointer];
}

void Tokeniser::Tokenise(){
    std::ifstream infile;
    infile.open(current_file_path);

    // reset token buffer
    token_pointer = 0;
    tokens = {};

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
            } else if ((line.find("//") != std::string::npos) && (line.find("//") != 0 && ignore == false)) {
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
            //std::cout << match.str() << std::endl;
        }
        
    }

}

bool Tokeniser::HasMoreTokens(){
    return (token_pointer < tokens.size());
}

void Tokeniser::Advance(){
    token_pointer++;

    if (token_pointer == tokens.size()){
        current_token = tokens[token_pointer-1];
    }
    else{
        current_token = tokens[token_pointer];
    }
    
}

std::string Tokeniser::GetCurrentToken(){
    return current_token;
}

std::string Tokeniser::GetSpecificType(std::string tkn){
    std::regex classVarDecP(classVarDec);
    std::regex typeP(type);
    std::regex subTypeP(subType);
    std::regex subRetTypeP(subRetType);
    std::regex keywordConstP(keywordConst);
    std::regex statementsP(statements);
    std::regex operatorsP(operators);

    if (std::regex_match(tkn, classVarDecP)){
        return "CLASSVARDEC";
    } else if (std::regex_match(tkn, statementsP)){
        return "STATEMENT";
    } else if (std::regex_match(tkn, subTypeP)){
        return "SUBTYPE";
    } else if (std::regex_match(tkn, keywordConstP)){
        return "KEYWORD_CONST";
    } else if (std::regex_match(tkn, typeP)){
        return "TYPE";
    } else if (std::regex_match(tkn, subRetTypeP)){
        return "SUBRETTYPE";
    } else if (std::regex_match(tkn, operatorsP)){
        return "OPERATOR";
    } else {
        return "unknown";
    }
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
        return "unknown";
    }
    
}

void Tokeniser::SaveTokens(std::string input_path){
    // T flag to show that the output path must is a file containing tokens not parse tree
    std::string output_path = GetOutputPath(input_path, ".xml", "T");

    std::ofstream output_file(output_path);
    
    output_file << "<tokens>" << std::endl;

    for (auto& token : tokens){
        current_token = token;
    
        output_file << GetTokenXML(GetCurrentToken(), GetTokenType()) << std::endl;
    }
    
    output_file << "</tokens>" << std::endl;

    std::cout << "Done saving tokens to: " << output_path << std::endl;
}


