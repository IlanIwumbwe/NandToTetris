#ifndef HELPER_FUNCS_HPP
#define HELPER_FUNCS_HPP

#include <string>
#include <filesystem>
#include <vector>

namespace fs = std::filesystem;

std::vector<std::string> GetFilesToParse(std::string &path);
std::string GetOutputPath(std::string &input_path, std::string output_extension);
std::vector<std::string> splitString(std::string input_string, std::string delimeter);
std::string removeTrailingWhitespace(std::string str);

#endif 