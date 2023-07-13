import os

FILE_PATH = input('Input path of Jack file: ').strip()

class Tokenise:
    def __init__(self, current_file):
        self.current_file = current_file
        self.current_token = ''

    def hasMoreTokens(self):
        pass

    def advance(self):
        pass
    
    def tokenType(self):
        pass

    def keyWord(self):
        pass

    def symbol(self):
        return self.current_token
    
    def identifier(self):
        return self.current_token
    
    def intVal(self):
        return int(self.current_token)
    
    def stringVal(self):
        return self.current_token


class Compile:
    def __init__(self):
        pass


class Analyse:
    def __init__(self):
        pass


if __name__ == "__main__":
    pass