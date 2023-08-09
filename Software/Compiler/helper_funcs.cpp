#include <vector>
#include <filesystem>
#include <iostream>
#include <string>
#include <map>
#include <regex>
#include "./helper_funcs.hpp"

namespace fs = std::filesystem;

XML_TAGS xml_tags;

std::vector<std::string> GetFilesToParse(std::string &path, std::string input_extension){
    std::vector<std::string> paths;

    if (!fs::is_directory(path)){
        paths.push_back(path);
        return paths;
    } else{
        std::string main_path = "";

        for (const auto& entry : fs::directory_iterator(path))
        {   
            if (entry.path().filename() == "Main" + input_extension){
                main_path = entry.path().string();
            } else if (entry.path().extension() == input_extension){
                paths.push_back(entry.path().string());
            }
        }

        if (main_path == ""){
            std::cout << "Entry point should be named 'Main'" << std::endl;
        } else {
            // enforce compilation order so that all classes are defined
            paths.push_back(main_path);
        }   
    }

    return paths;
}

std::string GetOutputPath(std::string &input_path, std::string output_extension, std::string compiler_flag){
    fs::path path(input_path);

    if (fs::is_directory(path)){
        return input_path + "\\" + path.filename().string() + output_extension;   
        
    } else {
        if (compiler_flag != ""){
            output_extension = (compiler_flag == "T") ? "T.xml" : ".xml";
        }

        std::regex pattern(R"(.jack)");
        return std::regex_replace(path.string(), pattern, output_extension);
    }
}

std::vector<std::string> splitString(const std::string& input, const std::string& delimiter) {
    std::vector<std::string> result;
    std::regex regexDelimiter(delimiter);
    std::sregex_token_iterator iterator(input.begin(), input.end(), regexDelimiter, -1);

    // Use sregex_token_iterator to split the string and add tokens to the result vector
    while (iterator != std::sregex_token_iterator()) {
        result.push_back(*iterator);
        ++iterator;
    }

    return result;
}

std::string removeWhiteSpace(std::string str){
    std::regex pattern(R"(^\s+|\s+$)");

    return std::regex_replace(str, pattern, "");
}

std::string GetTokenXML(std::string tkn, std::string tkn_type){

    std::string xml = xml_tags.GetXmlTag(tkn_type);
    std::regex pattern("_");
    
    if (tkn == "<"){
        return std::regex_replace(xml, pattern, " &lt; ");
    } else if (tkn == ">"){
        return std::regex_replace(xml, pattern, " &gt; ");
    } else if (tkn == "\""){
        return std::regex_replace(xml, pattern, " &quot; ");
    } else if (tkn == "&"){
        return std::regex_replace(xml, pattern, " &amp; ");
    } else {
        std::regex str_const_pattern(R"("[^\n\"]+")");

        if (std::regex_match(tkn, str_const_pattern)){
            tkn.erase(std::remove(tkn.begin(), tkn.end(), '\"'), tkn.end());
        }
        return std::regex_replace(xml, pattern, " "  + tkn + " ");
    }
}