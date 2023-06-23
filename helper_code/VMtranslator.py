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
                return [f'@{index}', 'D=A', '@SP','A=M',f'M=D','@SP','M=M+1']

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

    def endLoop(self):
        return ['(END)','@END','0;JMP']


class VMTranslator:
    def __init__(self):
        self.parser = Parser()
        self.codewriter = CodeWriter()

    def translate(self, file_paths):
        
        for path in file_paths:
            commands = self.parser.parse(path)
            self.codewriter.current_file_path = path

            assembly = []

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

                if command_type == 'C_POP':
                    code = self.codewriter.writePushPop('pop', arg1, arg2)
                    #print(code, i)
                    assembly.extend(code)

                if command_type == 'C_ARITHMETIC':
                    assembly.extend(self.codewriter.writeArithmetic(arg1, ind))

        assembly.extend(['// end loop'])
        assembly.extend(self.codewriter.endLoop())

        if len(file_paths) > 1:
            # file directory with multiple .vm files was passed, save .asm file in folder
            new_path = FILE_PATH + '/' + FILE_PATH.split('/')[-1] + '.asm'
        else:
            # single .vm file was passed

            if not FILE_PATH.startswith("."):
                # file path specified from current directory
                new_path = FILE_PATH.split('.')[0]+'.asm' 
            else:   
                new_path = '.' + FILE_PATH.split('.')[1]+'.asm'

        asm = open(new_path, 'w')
        asm.write('\n'.join(assembly))


if __name__ == "__main__":
    vmt = VMTranslator()

    print(os.path.isdir(FILE_PATH))

    if not os.path.isdir(FILE_PATH):
        vmt.translate([FILE_PATH])
    else:
        vmt.translate(os.listdir(FILE_PATH))


