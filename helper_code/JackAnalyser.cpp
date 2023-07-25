#include <iostream>
#include <fstream>
#include "./Compiler.hpp"
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"

int main()
{
    std::string FILE_PATH;

    std::cout << "Enter path of Jack file(s): ";
    std::cin >> FILE_PATH;
    
    std::vector<std::string> paths = GetFilesToParse(FILE_PATH, ".jack");

    Tokeniser tk;
    Compiler cp;

    for (std::string path : paths){
        // for each file, set it as the file to be tokenised, tokenise and save them in an xml doc
        tk.SetFilePath(path);
        tk.Tokenise();
        tk.SaveTokens(path);
        tk.InitialiseCurrToken(); // set current token to top of token buffer
        /* send tokens to compiler for full compilation 
            C is a compiler save flag, so that the loaded output path is correct
        */ 
        cp.SetTokeniser(tk);
        std::string output_path = GetOutputPath(path, ".xml", "C");
        cp.Compile(output_path);
    
    }

}