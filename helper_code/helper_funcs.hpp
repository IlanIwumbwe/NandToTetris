#pragma once
#include <string>
#include <filesystem>
#include <vector>
#include <algorithm>

namespace fs = std::filesystem;

std::vector<std::string> GetFilesToParse(std::string &path, std::string input_extension);
std::vector<std::string> GetOutputPaths(std::string &input_path, std::string output_extension, std::string compiler_flag);
std::vector<std::string> splitString(std::string input_string, std::string delimeter);
std::string removeWhiteSpace(std::string str);
