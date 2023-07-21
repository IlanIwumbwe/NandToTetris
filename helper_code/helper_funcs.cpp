#include <vector>
#include <filesystem>
#include <string>
#include <regex>
#include "./helper_funcs.hpp"

namespace fs = std::filesystem;

std::vector<std::string> GetFilesToParse(std::string &path, std::string input_extension){
    std::vector<std::string> paths;

    if (!fs::is_directory(path)){
        paths.push_back(path);
        return paths;
    } else{
        for (const auto& entry : fs::directory_iterator(path))
        {   
            if (entry.path().extension() == input_extension){
                paths.push_back(entry.path().string());
            }
        }
    }

    return paths;
}

std::vector<std::string> GetOutputPaths(std::string &input_path, std::string output_extension, std::string compiler_flag){
    std::vector<std::string> output_paths;
    fs::path path(input_path);

    if (fs::is_directory(path)){
        output_paths.push_back(input_path + "\\" + path.filename().string() + output_extension);   
        
    } else {
        if (compiler_flag != ""){
            output_extension = (compiler_flag == "T") ? "T.xml" : ".xml";
        }

        std::regex pattern(R"(.jack)");
        output_paths.push_back(std::regex_replace(path.string(), pattern, output_extension));
    }

    return output_paths;
}

std::vector<std::string> splitString(std::string input_string, std::string delimeter){

    std::vector<std::string> tokens;
    std::stringstream ss(input_string);
    std::string token;

    while (std::getline(ss, token, delimeter[0]))
    {
        tokens.push_back(token);
    }

    return tokens;

}

std::string removeWhiteSpace(std::string str){
    std::regex pattern(R"(^\s+|\s+$)");

    return std::regex_replace(str, pattern, "");
}

