import sys

def instrc_to_mif(input_filename, output_filename):
    data = []
    
    # Read the hex values from the input file
    with open(input_filename, 'r') as file:
        data = file.readlines()

    # Ensure data length is less than or equal to the memory size (2KB)
    memory_size = 8192  # 8KB memory size
    if len(data) > memory_size:
        print("Error: Data size exceeds memory size.")
        return

    # Create the MIF file
    with open(output_filename, 'w') as mif_file:
        mif_file.write("DEPTH = {};\n".format(memory_size))
        mif_file.write("WIDTH = 32;\n")
        mif_file.write("ADDRESS_RADIX = HEX;\n")
        mif_file.write("DATA_RADIX = HEX;\n")
        mif_file.write("CONTENT\n")
        mif_file.write("BEGIN\n")

        # Write the data to the MIF file
        for i in range(len(data)):
            value = data[i].strip().split('0x')[1]  # Remove leading/trailing whitespace
            address = hex(i)[2:].upper().zfill(4)
            mif_file.write("{} : {};\n".format(address,value))

        # Fill the remaining memory with zeros
        for i in range(len(data), memory_size >> 2):
            address = hex(i)[2:].upper().zfill(4)
            mif_file.write("{} : 00000000;\n".format(address))

        mif_file.write("END;\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python hex_to_mif.py input.hex output.mif")
    else:
        input_filename = sys.argv[1]
        output_filename = sys.argv[2]
        instrc_to_mif(input_filename, output_filename)
        print("Conversion complete. MIF file saved as", output_filename)
