#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <regex>
#include <map>
#include <sstream>
#include "./helper_funcs.hpp"

class Parser
{
    public:
        Parser()
        {
            curr_command = "";
        }

        void setCurrentCommand(std::string command)
        {
            curr_command = command;
        }

        std::vector<std::string> Parse(std::string current_file_path)
        {
            std::ifstream infile;
            infile.open(current_file_path);

            std::vector<std::string> instructions;

            if (!infile.is_open())
            {
                std::cout << "Error while opening file..." << std::endl;
            }

            std::string line;

            while (std::getline(infile, line))
            {   
                // each line read has no newline character

                if (line.size() != 0){
                    if ((line.find("//") != std::string::npos) && (line.find("//") != 0)){
                        // comment in line
                        std::vector<std::string> parts = splitString(line, "//");
                                    
                        instructions.push_back(removeWhiteSpace(parts[0]));
                
                    } else if (line.find("//") == std::string::npos) {
                        // no comment in line
                        instructions.push_back(removeWhiteSpace(line));
                    }
                }
            }
            
            /*
            for (auto ins : instructions){
                std::cout << ins << std::endl;
            }
            */

            return instructions;
        }

        std::string commandType(){
            if (curr_command == "return")
            {
                return "C_RETURN";
            }
            else{
                std::vector<std::string> parts = splitString(curr_command, " ");

                if (parts.size() == 1){
                    // add, sub
                    return "C_ARITHMETIC";
                }
                else{
                    // len = 2: goto, label, if
                    // len = 3: push, pop, function, call

                    std::string seg = parts[0];

                    std::transform(seg.begin(), seg.end(), seg.begin(), ::toupper);

                    return "C_" + seg;
                }
            }
        }

        std::string Arg1()
        {
            // get first argument of current instruction
            if (commandType() == "C_ARITHMETIC")
            {
                return curr_command;
            }
            else{
                return splitString(curr_command, " ")[1];
            }
        }

        std::string Arg2()
        {
            return splitString(curr_command, " ")[2];
        }
        
    private:
        std::string curr_command;

};

class CodeWriter{
    public:
        CodeWriter(){
            current_file_path = "";
            current_function = "";
            calls[""] = 0;
            
            OPS["add"] = "+";
            OPS["sub"] = "-";
            OPS["neg"] = "-";
            OPS["eq"] = "JEQ";
            OPS["gt"] = "JGT";
            OPS["lt"] = "JLT";
            OPS["and"] = "&";
            OPS["or"] = "|";
            OPS["not"] = "!";
        }

        void SetFilePath(std::string current_path){
            current_file_path = current_path;
        }

        std::string WriteBootstrapCode(){
            std::string assembly_code = "@256\nD=A\n@SP\nM=D\n" + WriteCall("Sys.init", "0");

            return assembly_code;
        }

        std::string WriteArithmetic(const std::string command, const int command_index)
        {
            if (command == "add" || command == "sub" || command == "and" || command == "or"){
                return "@SP\nAM=M-1\nD=M\nA=A-1\nM=M" + OPS[command] + "D";

            } else if (command == "gt" || command == "lt" || command == "eq"){
                // D=M-D -> M is x, D is y
                // x-y
                // jump to set top of stack to true 
                return "@SP\nAM=M-1\nD=M\n@SP\nAM=M-1\nD=M-D\n@TRUE" + std::to_string(command_index) + "\nD;" + OPS[command] + "\nD=0\n@PUSHTOSTACK" + std::to_string(command_index) + "\n0;JMP\n" + "(TRUE" + std::to_string(command_index) +")\nD=-1\n(PUSHTOSTACK" + std::to_string(command_index) + ")\n@SP\nA=M\nM=D\n@SP\nM=M+1";

            } else if (command == "neg" || command == "not"){
                // pop value off stack, apply operation onto it
                return "@SP\nA=M\nA=A-1\nM=" + OPS[command] + "M";

            } else {
                return "ERROR!";
                std::cout << "Invalid arithmetic-logical command";
            }      
        }

        std::string WritePushPop(const std::string command, const std::string segment, const std::string index){
            if (command == "push")
            {   
                if (segment == "constant"){
                    return "@" + index +"\nD=A\n" + pushToStack;
                    
                } else if (segment == "this" || segment == "that"){
                    std::string seg = segment;

                    std::transform(seg.begin(), seg.end(), seg.begin(), ::toupper);

                    return "@" + seg + "\nD=M\n@" + index + "\nA=D+A\nD=M\n" + pushToStack;

                } else if (segment == "temp"){

                    return "@TEMP\nD=A\n@" + index + "\nA=D+A\nD=M\n" + pushToStack;

                } else if (segment == "local"){

                    return "@LCL\nD=M\n@" + index + "\nA=D+A\nD=M\n" + pushToStack;

                } else if (segment == "argument"){

                    return "@ARG\nD=M\n@" + index + "\nA=D+A\nD=M\n" + pushToStack;

                } else if (segment == "pointer"){
                    // index = 0 -> this pointer
                    // index = 1 -> that pointer

                    return (index == "0") ? WritePushPop("push", "this", "0") : WritePushPop("push", "that", "0");

                } else if (segment == "static"){
                    std::string symbol = splitString(fs::path(current_file_path).filename().string(), ".")[0] + "." + index;

                    return "@" + symbol +"\nD=M\n" + pushToStack; 
                }

                else {
                    std::cout << segment << "Is an invalid segment input for push / pop instruction" << std::endl;
                    return "ERROR!";
                }
                
            } else {
                
                if (segment == "constant"){

                    std::cout << "Cannot change values of memory segments via pop command" << std::endl;
                    return "ERROR!";
                    
                } else if (segment == "this" || segment == "that"){
                    std::string seg = segment;

                    std::transform(seg.begin(), seg.end(), seg.begin(), ::toupper);

                    return "@" + seg + "\nD=M\n@" + index + "\nD=D+A\n" + popFromStack;

                } else if (segment == "temp"){

                    return "@TEMP\nD=A\n@" + index + "\nD=D+A\n" + popFromStack;

                } else if (segment == "local"){

                    return "@LCL\nD=M\n@" + index + "\nD=D+A\n" + popFromStack;

                } else if (segment == "argument"){

                    return "@ARG\nD=M\n@" + index + "\nD=D+A\n" + popFromStack;

                } else if (segment == "pointer"){
                    // index = 0 -> this pointer
                    // index = 1 -> that pointer

                    return (index == "0") ? "@SP\nAM=M-1\nD=M\n@THIS\nM=D" : "@SP\nAM=M-1\nD=M\n@THAT\nM=D";

                } else if (segment == "static"){
                    std::string symbol = splitString(fs::path(current_file_path).filename().string(), ".")[0] + "." + index;

                    return "@SP\nAM=M-1\nD=M\n@" + symbol + "\nM=D"; 
                }

                else {
                    std::cout << segment << "Is an invalid segment input for push / pop instruction" << std::endl;
                    return "ERROR!";
                }

            }
        }

        std::string WriteLabel(std::string label){
            return "(" + current_function + "$" + label + ")";
        } 

        std::string WriteGoTo(std::string label){
            return "@" + current_function + "$" + label + "\n0;JMP";
        }

        std::string WriteIfGoTo(std::string label){
            return "@SP\nAM=M-1\nD=M\n@" + current_function + "$" + label + "\nD;JNE";
        }

        std::string WriteFunction(std::string functionName, std::string nLVars){
            current_function = functionName;
            calls[current_function] = 0;

            std::string assembly_code = "(" + current_function + ")";

            for(int i = 0; i < std::stoi(nLVars); i++)
            {
                assembly_code += "\n@SP\nA=M\nM=0\n@SP\nM=M+1";
            }

            return assembly_code;
        }

        std::string WriteCall(std::string functionName, std::string nArgs){
            /*
            before call command, all function arguments have been pushed onto the stack, nArgs needed here to reposition the ARG pointer correctly
            this function should save the stack frame of the caller function, reposition LCL and ARG pointers, transfer control to the function, 
            and add return address into code
            */

            if (current_function != "")
            {
                calls[current_function] += 1;
            }

            std::string assembly_code = "// push stack frame of caller\n@" + current_function + "$ret." + std::to_string(calls[current_function]) + "\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1\n";

            for (const auto& pointer : pointers){
                assembly_code += ("@" + pointer + "\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n");
            }

            assembly_code += "// reposition ARG and LCL pointers\n@SP\nD=M\n@LCL\nM=D\n@" + std::to_string(5 + std::stoi(nArgs)) + "\nD=D-A\n@ARG\nM=D\n//GOTO function\n"; 
            assembly_code += "@" + functionName + "\n0;JMP\n(" + current_function + "$ret." + std::to_string(calls[current_function]) + ")";
        
            return assembly_code;

        }

        std::string WriteReturn(){
            /*
            access caller stack frame and restore values for the caller, repoisition SP for caller, reposition return address of caller
            */

            std::string assembly_code;
            
            assembly_code += "@LCL\nD=M\n@R13\nM=D  // R13 now stores the base of the frame\n@5\nA=D-A\nD=M\n@R14\nM=D   // R14 now stores the return address\n";
            assembly_code += "// add return value of the caller to arg0 in ARG_segment\n@SP\nAM=M-1\nD=M\n@ARG\nA=M\nM=D\n// change value of stack pointer for caller\n@ARG\nD=M\n";
            assembly_code += "@SP\nM=D+1\n// restore base addresses of caller\n"; 

            std::vector<std::string> reversed(pointers.rbegin(), pointers.rend());

            for (const auto& pointer : reversed){
                assembly_code += ("@R13\nAM=M-1\nD=M  // D = *(FRAME - (i+1))\n@" + pointer + "\nM=D\n");
            }

            assembly_code += "// jump to return address, giving control back to caller\n@R14\nA=M\n0;JMP";

            return assembly_code;
        }

        std::string WriteEndLoop(){
            return "(END)\n@END\n0;JMP";
        }

    private:
        std::string current_file_path;
        std::string current_function;
        std::map<std::string, int> calls;

        std::map<std::string, std::string> OPS;
    
        std::vector<std::string> pointers {"LCL", "ARG", "THIS", "THAT"};

        std::string pushToStack = "@SP\nA=M\nM=D\n@SP\nM=M+1";

        // R13 is used to store address to which data from stack should be popped
        std::string popFromStack = "@R13\nM=D\n@SP\nAM=M-1\nD=M\n@R13\nA=M\nM=D";

};

class VMtranslator{

    public:
        VMtranslator() {}

        void Translate(std::vector<std::string> file_paths, std::ofstream &output_file){
            // add bootstrap code
            std::string command_type, arg1, arg2;

            std::string out_path;

            output_file << "// bootstrap code, set SP=256, and call Sys.init\n" + codewriter.WriteBootstrapCode() << std::endl;

            for (const auto & current_path : file_paths){
                std::vector<std::string> instructions = parser.Parse(current_path);

                codewriter.SetFilePath(current_path);

                for (int index = 0; index < instructions.size(); index++){

                    output_file << "//" + instructions[index] << std::endl;
                    parser.setCurrentCommand(instructions[index]);

                    command_type = parser.commandType();

                    arg1 = (command_type != "C_RETURN") ? parser.Arg1() : "";
                    arg2 = (command_type == "C_PUSH" || command_type == "C_POP" || command_type == "C_FUNCTION" || command_type == "C_CALL") ? parser.Arg2() : "";

                    if (command_type == "C_PUSH"){
                        output_file << codewriter.WritePushPop("push", arg1, arg2) << std::endl;

                    } else if (command_type == "C_POP"){
                        output_file << codewriter.WritePushPop("pop", arg1, arg2) << std::endl;

                    } else if (command_type == "C_ARITHMETIC"){
                        output_file << codewriter.WriteArithmetic(arg1, index) << std::endl;

                    } else if (command_type == "C_FUNCTION"){
                        output_file << codewriter.WriteFunction(arg1, arg2) << std::endl;

                    } else if (command_type == "C_CALL"){
                        output_file << codewriter.WriteCall(arg1, arg2) << std::endl;

                    } else if (command_type == "C_RETURN"){
                        output_file << codewriter.WriteReturn() << std::endl;

                    } else if (command_type == "C_LABEL"){
                        output_file << codewriter.WriteLabel(arg1) << std::endl;

                    } else if (command_type == "C_GOTO"){
                        output_file << codewriter.WriteGoTo(arg1) << std::endl;

                    } else {
                        // if-goto function
                        output_file << codewriter.WriteIfGoTo(arg1) << std::endl;
                    }
                }
            }

            // end assembly program

            output_file << "// end loop\n" + codewriter.WriteEndLoop() << std::endl;

            output_file.close();
        }

    private:
        Parser parser;
        CodeWriter codewriter;

};


int main()
{
    std::string FILE_PATH;

    std::cout << "Enter path of VM file: ";
    std::cin >> FILE_PATH;

    std::vector<std::string> paths = GetFilesToParse(FILE_PATH, ".vm");

    VMtranslator vmt;
    
    std::string output_path = GetOutputPath(FILE_PATH, ".asm", "");
    std::ofstream outfile(output_path);

    vmt.Translate(paths, outfile);

    std::cout << "Done writing assembly to: " << output_path << std::endl;

    return 0;
}