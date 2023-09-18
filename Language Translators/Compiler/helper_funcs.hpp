#pragma once
#include <string>
#include <filesystem>
#include <vector>
#include <algorithm>
#include <regex>

namespace fs = std::filesystem;

struct XML_TAGS{
    std::string keyword = "<keyword>_</keyword>";
    std::string symbol = "<symbol>_</symbol>";
    std::string int_const = "<integerConstant>_</integerConstant>";
    std::string str_const = "<stringConstant>_</stringConstant>";
    std::string identifier = "<identifier>_</identifier>";

    std::string GetXmlTag(std::string tkn_type){
        if (tkn_type == "KEYWORD"){
            return keyword;
        } else if (tkn_type == "SYMBOL"){
            return symbol;
        } else if (tkn_type == "INT_CONST"){
            return int_const;
        } else if (tkn_type == "STRING_CONST"){
            return str_const;
        } else {
            return identifier;
        }
    }
};

std::vector<std::string> GetFilesToParse(std::string &path, std::string input_extension);
std::string GetOutputPath(std::string &input_path, std::string output_extension, std::string compiler_flag);
std::vector<std::string> splitString(const std::string& input, const std::string& delimiter);
std::string removeWhiteSpace(std::string str);
std::string GetTokenXML(std::string tkn, std::string tkn_type);