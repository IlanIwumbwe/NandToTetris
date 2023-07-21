#include <iostream>
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./Compiler.hpp"

Compiler::Compiler(std::string output_path){
    output_file_path = output_path;
}








int main()
{
    std::string FILE_PATH;

    std::cout << "Enter path of Jack file: ";
    std::cin >> FILE_PATH;
    
    
    std::vector<std::string> paths = GetFilesToParse(FILE_PATH, ".jack");

    Tokeniser tk;

    for (const auto& path : paths){
        tk.SetFilePath(path);
        tk.GetTokens();
        tk.SaveTokens(path);
    }

}