#include <iostream>
#include <fstream>
#include "./JackTokeniser.hpp"
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./Compiler.hpp"
#include "./VMtranslator.hpp"

int main()
{
    std::string FILE_PATH, tokens_choice, vmToASM_choice;

    std::cout << "Enter path of Jack file(s): ";
    std::cin >> FILE_PATH;

    std::cout << "Get tokens in file? (Y/N): ";
    std::cin >> tokens_choice;

    std::cout << "Translate VM code into assembly (Y/N): ";
    std::cin >> vmToASM_choice;
    
    std::vector<std::string> paths = GetFilesToParse(FILE_PATH, ".jack");

    Lexer lexer;
    CompilerXML cpXML;

    Compiler cp;

    std::string output_path;

    for (std::string path : paths){
        output_path  = "";
        // for each file, set it as the file to be tokenised, tokenise and save them in an xml doc
        lexer.SetFilePath(path);
        lexer.Lex();
        
        /* send tokens to compiler for full compilation 
            C is a compiler save flag, so that the loaded output path is correct
        */ 

        if (tokens_choice == "Y" || tokens_choice == "y"){ 
            lexer.SaveTokens(path);  // save program tokens   
            // this compiler gives XML output
            lexer.InitialiseCurrToken(); // set current token to top of token buffer
            output_path = GetOutputPath(path, ".xml", "C");
            cpXML.Compile(output_path, lexer);
        } 
        
        // this compiler gives .vm output
        lexer.InitialiseCurrToken(); // set current token to top of token buffer
        output_path = GetOutputPath(path, ".vm", "");
        cp.Compile(output_path, lexer);
    }

    if (vmToASM_choice == "Y" || vmToASM_choice == "y"){
        paths = GetFilesToParse(FILE_PATH, ".vm");

        VMtranslator vmt;
    
        output_path = GetOutputPath(FILE_PATH, ".asm", "");
        std::ofstream outfile(output_path);

        vmt.Translate(paths, outfile);

        std::cout << "Done writing assembly to: " << output_path << std::endl;
    }

    return 0;
}