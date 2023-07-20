#include <vector>
#include <filesystem>
#include <string>
#include "./helper_funcs.hpp"

namespace fs = std::filesystem;

std::vector<std::string> GetFilesToParse(std::string &path){
    std::vector<std::string> paths;

    if (!fs::is_directory(path)){
        paths.push_back(path);
        return paths;
    } else{
        for (const auto& entry : fs::directory_iterator(path))
        {   
            if (entry.path().extension() == ".vm"){
                paths.push_back(entry.path().string());
            }
        }
    }

    return paths;
}

std::string GetOutputPath(std::string &input_path, std::string output_extension){
    fs::path path(input_path);

    if (fs::is_directory(path)){
        return input_path + "\\" + path.filename().string() + output_extension;   
    }
    else{
        return path.replace_extension(output_extension).string();
    }
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

std::string removeTrailingWhitespace(std::string str){
 
    // Remove trailing whitespace
    std::string_view strView(str);

    size_t end = strView.find_last_not_of(" \t\r\n");

    if (end != std::string_view::npos)
    {
        str.resize(end + 1);
    }
    else
    {
        str.clear();
    }

    return str;
}