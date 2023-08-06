#include <iostream>
#include <fstream>
#include "./JackTokeniser.hpp"
#include "./Lexer.hpp"
#include "./helper_funcs.hpp"
#include "./Compiler.hpp"

int main()
{
    std::string FILE_PATH;

    std::cout << "Enter path of Jack file(s): ";
    std::cin >> FILE_PATH;
    
    std::vector<std::string> paths = GetFilesToParse(FILE_PATH, ".jack");

    Lexer lexer;
    CompilerXML cpXML;

    SymbolTable cLSymbolTable;
    SymbolTable sLSymbolTable;
    VMWriter vmwriter;
    Compiler cp;

    for (std::string path : paths){
        std::string output_path  = "";
        // for each file, set it as the file to be tokenised, tokenise and save them in an xml doc
        lexer.SetFilePath(path);
        lexer.Lex();
        lexer.SaveTokens(path);
        lexer.InitialiseCurrToken(); // set current token to top of token buffer
        /* send tokens to compiler for full compilation 
            C is a compiler save flag, so that the loaded output path is correct
        */ 
        // this compiler gives XML output
        // cpXML.SetLexer(lexer);
        // output_path = GetOutputPath(path, ".xml", "C");
        // cpXML.Compile(output_path);
        
        // this compiler gives .vm output
        cp.SetLexer(lexer);
        cp.SetSymbolTables(cLSymbolTable, sLSymbolTable);
        cp.SetVMWriter(vmwriter);

        output_path = GetOutputPath(path, ".vm", "");
        cp.Compile(output_path);
    }

}