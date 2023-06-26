import os

FILE_PATH = input('Input path of VM file: ').strip()
OPS = {'add':'+', 'sub':'-', 'neg':'-', 'eq':'JEQ', 'gt':'JGT', 'lt':'JLT', 'and':'&', 'or':'|', 'not':'!'}


class Parser:
    def __init__(self):
        self.current_command = ''

    def parse(self, current_file_path):
        with open(current_file_path, 'r') as cm:
            instructions = []

            for i in cm.readlines():
                if i != '\n':
                    if '//' in i and i.split('//')[0] != '':
                        instructions.append(i.split('//')[0].strip())

                    if '//' not in i:
                        instructions.append(i.replace('\n','').strip())

        return instructions

    def commandType(self):
        parts = self.current_command.split(' ')

        if self.current_command == 'return':
            return 'C_RETURN'
        else:    
            if len(parts) == 1:
                # add, sub
                return 'C_ARITHMETIC'
            
            else:
                # len = 2: goto, label, if
                # len = 3: push, pop, function, call
                return f'C_{parts[0].upper()}'

    def arg1(self):
        # return segment
        
        if self.commandType() == 'C_ARITHMETIC':
            return self.current_command

        else:
            return self.current_command.split(' ')[1]

    def arg2(self):
        return self.current_command.split(' ')[2]


class CodeWriter:
    def __init__(self):
        # will be passed as needed, used for adding labels to the assembly code
        self.current_file_path = ''
        self.current_function = ''
        self.calls = 0
        
    def setFilePath(self, file_path):
        self.current_file_path = file_path

    def writeBootstrapCode(self):
        return ['@256', 'D=A', '@SP', 'M=D'] + self.writeCall('Sys.init', 0)

    def writeArithmetic(self, command, command_index):
        # will be string
        if command in ['add', 'sub', 'and', 'or']:
            return ['@SP', 'AM=M-1', 'D=M', 'A=A-1', f'M=M{OPS[command]}D']

        elif command in ['eq', 'lt', 'gt']:
            # D=M-D -> M is x, D is y
            # x-y
            # jump to set top of stack to true 
            return ['@SP','AM=M-1', 'D=M', '@SP', 'AM=M-1', 'D=M-D', f'@TRUE{command_index}', f'D;{OPS[command]}', 'D=0', f'@PUSHTOSTACK{command_index}', '0;JMP', f'(TRUE{command_index})', 'D=-1', f'(PUSHTOSTACK{command_index})', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

        elif command in ['neg', 'not']:
            # pop value off stack, apply operation onto it
            return ['@SP','A=M','A=A-1',f'M={OPS[command]}M']

        else:
            return SyntaxError('Invalid arithmetic-logical command')

    def writePushPop(self, command, segment, index):
        if command == 'push':
            if segment == 'constant':
                return [f'@{index}', 'D=A', '@SP','A=M', 'M=D','@SP','M=M+1']

            elif segment == 'local':
                return ['@LCL', 'D=M', f'@{index}', 'A=D+A', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'argument':
                return ['@ARG', 'D=M', f'@{index}', 'A=D+A', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'pointer':
                if index == '0':
                    return ['@THIS', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

                elif index == '1':
                    return ['@THAT', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'temp':
                return ['@TEMP', 'D=M', f'@{index}', 'A=D+A', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'this':
                return ['@THIS', 'D=M', f'@{index}', 'A=D+A', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'that':
                return ['@THAT', 'D=M', f'@{index}', 'A=D+A', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1']

            elif segment == 'static':
                symbol = self.current_file_path.split('.')[0]+f'.{index}'

                return [f'@{symbol}','D=M','@SP','A=M','M=D','@SP','M=M+1']

        if command == 'pop':
            if segment == 'constant':
                return SyntaxError('Cannnot change value of memory segments')

            elif segment == 'local':
                return ['@LCL', 'D=M', f'@{index}', 'D=D+A', '@R13', 'M=D', '@SP', 'AM=M-1', 'D=M', '@R13', 'A=M', 'M=D']

            elif segment == 'argument':
                return ['@ARG', 'D=M', f'@{index}', 'D=D+A', '@R13', 'M=D', '@SP', 'AM=M-1', 'D=M', '@R13', 'A=M', 'M=D']

            elif segment == 'pointer':
                if index == '0':
                    return ['@SP', 'AM=M-1', 'D=M', '@THIS', 'M=D']
                elif index == '1':
                    return ['@SP', 'AM=M-1', 'D=M', '@THAT', 'M=D']

            elif segment == 'this':
                return ['@THIS', 'D=M', f'@{index}', 'D=D+A', '@R13', 'M=D', '@SP', 'AM=M-1', 'D=M', '@R13', 'A=M', 'M=D']

            elif segment == 'that':
                return ['@THAT', 'D=M', f'@{index}', 'D=D+A', '@R13', 'M=D', '@SP', 'AM=M-1', 'D=M', '@R13', 'A=M', 'M=D']

            elif segment == 'temp':
                return ['@5', 'D=A', f'@{index}', 'D=D+A', '@R13', 'M=D', '@SP', 'AM=M-1', 'D=M', '@R13', 'A=M', 'M=D']

            elif segment == 'static':
                symbol = self.current_file_path.split('.')[0]+f'.{index}'

                return  ['@SP','AM=M-1','D=M',f'@{symbol}','M=D']
            
    def writeLabel(self, label : str): # label already in correct convention
        return [f'({self.current_function}${label})']  

    def writeGoTo(self, label : str): # label already in correct convention
        return [f'@{self.current_function}${label}', '0;JMP']

    def writeIfGoTo(self, label : str): # label already in correct convention
        return ['@SP', 'AM=M-1', 'D=M', f'@{self.current_function}${label}', 'D;JNE']
    
    def writeFunction(self, functionName, nLVars): # functionName already in correct convention
        # add entry label into code, initialise all local variables to 0 (use local segment)
        self.current_function = functionName 

        return [f'({self.current_function})', f'@{int(nLVars)-1}', 'D=A', '(CHECK)', '@FINISH_FUNC_INIT', 'D;JLT', '@SP', 'A=M', 'M=0', '@SP', 'M=M+1', 'D=D-1', '@CHECK', '0;JMP', '(FINISH_FUNC_INIT)']

    def writeCall(self, functionName, nArgs): # functionName already in correct convention
        '''
        before call command, all function arguments have been pushed onto the stack, nArgs needed here to reposition the ARG pointer correctly
        this function should save the stack frame of the caller function, reposition LCL and ARG pointers, transfer control to the function, 
        and add return address into code
        '''

        return ['// push stack frame of caller', f'@{self.current_function}$ret', 'D=A', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1'] + \
        ['@LCL', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1'] + \
        ['@ARG', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1'] + \
        ['@THIS', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1'] + \
        ['@THAT', 'D=M', '@SP', 'A=M', 'M=D', '@SP', 'M=M+1'] + \
        ['// reposition ARG and LCL pointers', '@SP', 'D=M', '@LCL', 'M=D', f'@{5 + int(nArgs)}', 'D=D-A', '@ARG', 'M=D'] + \
        ['//goto function', f'@{functionName}', '0;JMP', f'({self.current_function}$ret)'] 

    def writeReturn(self):
        '''
        access caller stack frame and restore values for the caller, repoisition SP for caller, reposition return address of caller
        '''
        return ['@LCL', 'D=M', '@R13', 'M=D   // R13 now stores the base of the frame', '@5', 'D=A', '@LCL', 'A=M-D', 'D=M', '@R14', 'M=D   // R14 now stores the return address'] + \
        ['// add return value of the caller to arg0 in ARG_segment', '@SP', 'AM=M-1', 'D=M', '@ARG', 'A=M', 'M=D'] + \
        ['// change value of stack pointer for caller', '@ARG','D=M','@SP', 'M=D+1'] + \
        ['// restore base addresses of caller', '@R13', 'A=M-1', 'D=M', '@THAT', 'M=D'] + \
        ['@2', 'D=A', '@R13', 'A=M-D', 'D=M', '@THIS', 'M=D'] + \
        ['@3', 'D=A', '@R13', 'A=M-D', 'D=M', '@ARG', 'M=D'] + \
        ['@4', 'D=A', '@R13', 'A=M-D', 'D=M', '@LCL', 'M=D'] + \
        ['// jump to return address, giving control back to caller', '@R14', 'A=M', '0;JMP']
    
    def endLoop(self):
        return ['(END)','@END','0;JMP']


class VMTranslator:
    def __init__(self):
        self.parser = Parser()
        self.codewriter = CodeWriter()

    def translate(self, file_paths):
        assembly = []

        # add bootstrap code
        assembly.extend(['// bootstrap code, set SP=256, and call Sys.init'] + self.codewriter.writeBootstrapCode())

        for path in file_paths:

            if os.path.isdir(FILE_PATH):
                # complete directory to parse correctly, for multiple .vm files
                commands = self.parser.parse(FILE_PATH + '\\' + path)
            else:
                # single .vm file was passed, so that file path should be PARSED
                commands = self.parser.parse(FILE_PATH)

            self.codewriter.setFilePath(path)

            for ind, i in enumerate(commands):
                assembly.extend([f'// {i}'])
                self.parser.current_command = i
                command_type = self.parser.commandType()

                if command_type != 'C_RETURN':
                    arg1 = self.parser.arg1()

                if command_type in ['C_PUSH', 'C_POP', 'C_FUNCTION', 'C_CALL']:
                    arg2 = self.parser.arg2()

                if command_type == 'C_PUSH':
                    assembly.extend(self.codewriter.writePushPop('push', arg1, arg2))

                elif command_type == 'C_POP':
                    assembly.extend(self.codewriter.writePushPop('pop', arg1, arg2))

                elif command_type == 'C_ARITHMETIC':
                    assembly.extend(self.codewriter.writeArithmetic(arg1, ind))

                elif command_type == 'C_FUNCTION':
                    # function name passed changed to conform to convention
                    # kept track of globally because func name is used in label, and return naming conventions
                    assembly.extend(self.codewriter.writeFunction(arg1 , arg2))

                elif command_type == 'C_CALL':
                    # handle call overhead to function

                    assembly.extend(self.codewriter.writeCall(arg1, arg2))

                elif command_type == 'C_RETURN':
                    # handle return overhead from function
                    assembly.extend(self.codewriter.writeReturn())

                elif command_type == 'C_LABEL':
                    # add labels to assembly code
                    assembly.extend(self.codewriter.writeLabel(arg1))

                elif command_type == 'C_GOTO':
                    # add assembly to jump to labels in assembly code unconditionally
                    assembly.extend(self.codewriter.writeGoTo(arg1))

                elif command_type == 'C_IF-GOTO':
                    # add assembly to jump to labels in assembly conditionally
                    assembly.extend(self.codewriter.writeIfGoTo(arg1))
                
        # end assembly program
        assembly.extend(['// end loop'])
        assembly.extend(self.codewriter.endLoop())

        if len(file_paths) == 1:
            # single .vm file was passed   
            new_path = FILE_PATH.replace('.vm', '.asm')
        else:
            # file directory with multiple .vm files was passed, save .asm file in folder
            new_path = FILE_PATH + '\\' + FILE_PATH.split('\\')[-1] + '.asm'
        
        asm = open(new_path, 'w')
        asm.write('\n'.join(assembly))


if __name__ == "__main__":
    vmt = VMTranslator()

    if not os.path.isdir(FILE_PATH):
        vmt.translate([os.path.basename(FILE_PATH)])
    else:
        # add only .vm files in folder to be translated
        print([f for f in os.listdir(FILE_PATH) if '.vm' in f])
        vmt.translate([f for f in os.listdir(FILE_PATH) if '.vm' in f])


