
# assembler to convert hack assembly code into machine code for the Hack CPU

import numpy as np

JUMP_CODES = {'null':'000', 'JGT':'001', 'JEQ':'010', 'JGE':'011', 'JLT':'100', 'JNE':'101', 'JLE':'110', 'JMP':'111'}
DEST_CODES = {'null':'000', 'M':'001', 'D':'010', 'MD':'011', 'A':'100', 'AM':'101', 'AD':'110', 'AMD':'111'}
COMP_CODES = {'0':'0101010', '1':'0111111', '-1':'0111010', 'D':'0001100', 'A':'0110000', '!D':'0001101', '!A':'0110001', '-D':'0001111', '-A':'0110011', 'D+1':'0011111', 'A+1':'0110111', 'D-1':'0001110', 'A-1':'0110010', 'D+A':'0000010', 'D-A':'0010011', 'A-D':'0000111', 'D&A':'0000000', 'D|A':'0010101',
				'M':'1110000', '!M':'1110001', '-M':'1110011', 'M+1':'1110111', 'M-1':'1110010', 'M+D':'1000010', 'D-M':'1010011', 'M-D':'1000111', 'D&M':'1000000', 'D|M':'1010101'}	

class Parser:
	def __init__(self):
		self.file_path = input('Input path of assembly file: ').strip()
		self.current_instruction = ''
		self.fields = []

	def instructionType(self):
		if self.current_instruction[0] == '@':
			# A-instruction or macros
			return 'A'

		elif '(' in self.current_instruction:
			# L-instruction
			return 'L'

		elif '=' in self.current_instruction or ';' in self.current_instruction:
			#compute instruction
			return 'C'

	def symbol(self):
		if self.instructionType() == 'L':
			return self.current_instruction.replace('(','').replace(')','')
		elif self.instructionType() == 'A':
			return self.current_instruction.replace('@','')

	def dest(self):
		if '=' in self.current_instruction:
			return self.current_instruction.split('=')[0]
		else:
			return 'null'

	def comp(self):
		if '=' in self.current_instruction:
			part = self.current_instruction.split('=')[1]

			if ';' not in part:
				return part
			else:
				return part.split(';')[0]

		if ';' in self.current_instruction:
			part = self.current_instruction.split(';')[0]

			if '=' not in part:
				return part
			else:
				return part.split('=')[1]

	def jump(self):
		if ';' in self.current_instruction:
			return self.current_instruction.split(';')[1]
		else:
			return 'null'

	def parse(self):
		with open(self.file_path, 'r') as asm:
			instructions = []

			for i in asm.readlines():
				if i != '\n':
					if '//' in i and i.split('//')[0] != '':
						instructions.append(i.split('//')[0].strip())

					if '//' not in i:
						instructions.append(i.replace('\n','').strip())

		return instructions


class Code:
	def __init__(self):
		pass

	def dest(self, dest):
		return DEST_CODES[dest]

	def comp(self, comp):
		return COMP_CODES[comp]

	def jump(self, jump):
		return JUMP_CODES[jump]

	def integer(self, integer):
		return np.binary_repr(int(integer), width=16)
		

class HackAssembler:
	def __init__(self):
		self.parser = Parser()
		self.binary_codes = Code()
		self.symbol_table = {'R0':'0', 'R1':'1', 'R2':'2', 'R3':'3', 'R4':'4', 'R5':'5', 'R6':'6', 'R7':'7', 'R8':'8', 'R9':'9', 'R10':'10', 
								'R11':'11', 'R12':'12', 'R13':'13', 'R14':'14', 'R15':'15', 'SCREEN':'16384', 'KBD':'24576', 'SP':'0', 'LCL':'1',
									'ARG':'2', 'THIS':'3', 'THAT':'4', 'TEMP': '5'}
		
	def asm(self):
		ins = self.parser.parse()

		if not self.parser.file_path.startswith("."):
			new_path = self.parser.file_path.split('.')[0]+'.hack' 
		else: 
			new_path = '.' + self.parser.file_path.split('.')[1]+'.hack'

		machine_code = open(new_path, 'w')
		codes = ''

		RAM_address = 16
		line_number = -1

		# 1st pass sorts out LABELS
		for i in ins:
			self.parser.current_instruction = i

			if self.parser.instructionType() == 'L':
				sym = self.parser.symbol()

				self.symbol_table[sym] = line_number + 1

			else:
				line_number += 1

		# 2nd pass
		for i in ins:
			self.parser.current_instruction = i

			if self.parser.instructionType() == 'A':
				sym = self.parser.symbol()

				if sym.isdigit():
					binary = self.binary_codes.integer(sym)
				else:
					if sym in self.symbol_table:
						binary = self.binary_codes.integer(self.symbol_table[sym])
					else:
						# symbol must represent a new varible
						self.symbol_table[sym] = RAM_address
						RAM_address += 1

				codes += binary+'\n'

			elif self.parser.instructionType() == 'C':
				dest = self.parser.dest()
				comp = self.parser.comp()
				jmp = self.parser.jump()

				binary = '111' + self.binary_codes.comp(comp)+self.binary_codes.dest(dest)+self.binary_codes.jump(jmp)

				codes += binary+'\n'


		machine_code.write(codes)

assembler = HackAssembler()

assembler.asm()

