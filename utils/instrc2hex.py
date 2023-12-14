import sys

def instrc_to_hex(input_filename, output_filename):
    data = []
    
    # Read the hex values from the input file
    with open(input_filename, 'r') as file:
        data = file.readlines()

    # Ensure data length is less than or equal to the memory size (2KB)
    memory_size = 8192 >> 2  # 8KB memory size
    if len(data) > memory_size:
        print("Error: Data size exceeds memory size.")
        return

    # Create the MIF file
    with open(output_filename, 'w') as hex_file:
        # Write the data to the MIF file
        for i in range(len(data)):
            value = data[i].strip().split('0x')[1]  # Remove leading/trailing whitespace
            # hex_values = [value[i:i+2] for i in range(2, len(value), 2)]
            # hex_values.reverse()
            # for h in hex_values:
            hex_file.write("{}\n".format(value))

        # Fill the remaining memory with zeros
        for i in range(len(data), memory_size >> 2):
            address = hex(i)[2:].upper().zfill(4)
            hex_file.write("00000000\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python hex_to_mif.py input.hex output.mif")
    else:
        input_filename = sys.argv[1]
        output_filename = sys.argv[2]
        instrc_to_hex(input_filename, output_filename)
        print("Conversion complete. HEX file saved as", output_filename)
