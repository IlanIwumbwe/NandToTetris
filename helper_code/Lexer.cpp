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
    int_constants = R"([0-32767])";
    string_constants = R"("[^\n\"]+")";
    identifiers = R"([a-zA-Z_]\w*)";
    
    // variable instantiation
    ignore = false;

    current_file_path = "";
    token_pointer = 0;
    current_token = "";

    xml_tags["KEYWORD"] = "<keyword>_</keyword>";
    xml_tags["SYMBOL"] = "<symbol>_</symbol>";
    xml_tags["INT_CONST"] = "<integerConstant>_</integerConstant>";
    xml_tags["STRING_CONST"] = "<stringConstant>_</stringConstant>";
    xml_tags["IDENTIFIER"] = "<identifier>_</identifier>";

}

void Tokeniser::SetFilePath(std::string current_path){
    current_file_path = current_path;
}

void Tokeniser::GetTokens(){
    std::ifstream infile;
    infile.open(current_file_path);

    // reset token buffer in case new file path has been passed
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
            //std::cout << match.str() << std::endl;
        }
        
    }

    current_token = tokens[token_pointer];

}

bool Tokeniser::HasMoreTokens(){
    return (token_pointer < tokens.size());
}

void Tokeniser::Advance(){
    token_pointer++;
    current_token = tokens[token_pointer];
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
        return "unknown";
    }
}

std::string Tokeniser::GetTokenXML(std::string tkn){

    if (tkn == "<"){
        return " &lt; ";
    } else if (tkn == ">"){
        return " &gt; ";
    } else if (tkn == "\""){
        return " &quot; ";
    } else if (tkn == "&"){
        return " &amp; ";
    } else {
        std::regex str_const_pattern(string_constants);

        if (std::regex_match(tkn, str_const_pattern)){
            tkn.erase(std::remove(tkn.begin(), tkn.end(), '\"'), tkn.end());
        }

        return " "  + tkn + " ";
        
    }
}

void Tokeniser::SaveTokens(std::string input_path){
    // T flag to show that the output path must is a file containing tokens not parse tree
    for(const auto& output_path : GetOutputPaths(input_path, ".xml", "T")){
        std::ofstream output_file(output_path);
        
        output_file << "<tokens>" << std::endl;

        for (auto& token : tokens){
            current_token = token;
            std::string xml = xml_tags[GetTokenType()];
            std::regex pattern("_");
        
            output_file << std::regex_replace(xml, pattern, GetTokenXML(current_token)) << std::endl;
        }
        
        output_file << "</tokens>" << std::endl;

    }
}


