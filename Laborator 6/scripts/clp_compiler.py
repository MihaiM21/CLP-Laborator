# Dictionar pentru codarea instructiunilor
instr_encoding = {
    "AND": "000",
    "ORR": "001",
    "XOR": "010",
    "MOV": "011",
    "ADD": "100",
    "SUB": "101",
    "SHL": "110",
    "SHR": "111"
}

# Dictionar pentru codarea adreselor
address_encoding = {
    "a0": "0000",
    "a1": "0001",
    "a2": "0010",
    "a3": "0011",
    "a4": "0100",
    "a5": "0101",
    "a6": "0110",
    "a7": "0111",
    "a8": "1000",
    "a9": "1001",
    "a10": "1010",
    "a11": "1011",
    "a12": "1100",
    "a13": "1101",
    "a14": "1110",
    "a15": "1111",
}


def binbits(x, n):
    bits = bin(int(x)).split('b')[1]

    if len(bits) < n:
        return '0' * (n - len(bits)) + bits
    else:
        return bits


def compile_program(assembly_program_path, compiled_program_path):
    program_file = open(assembly_program_path)
    compiled_program = open(compiled_program_path, "w")
    for line in program_file.readlines():
        if "#" in line:
            continue
        else:
            instruction, op1, op2, address = line.split()
            binary_instruction = instr_encoding[instruction]
            binary_op1 = binbits(op1, 8)
            binary_op2 = binbits(op2, 8)
            binary_address = address_encoding[address]
            mem_line = binary_instruction + binary_op1 + binary_op2 + binary_address
            compiled_program.write(mem_line + "\n")

    compiled_program.close()
    print("Compilation done!")


if __name__ == '__main__':
    compile_program("program.clp", "../sim/program.memb")
