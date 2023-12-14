import random
import sys

# Check if the correct number of arguments is provided
if len(sys.argv) != 4:
    print("Usage: python mem_gen.py <DEPTH> <WIDTH> <output_file>")
    sys.exit(1)

# Parse command line arguments
WIDTH = int(sys.argv[2])
DEPTH = int(sys.argv[1]) // (WIDTH // 8)
output_file = sys.argv[3]

# Generate random data for the memory
random_data = [random.randint(0, 255) for _ in range(DEPTH * (WIDTH // 8))]

# Open the specified output file for writing
with open(output_file, "w") as file:
    for i in range(DEPTH):
        data_chunk = random_data[i * (WIDTH // 8):(i + 1) * (WIDTH // 8)]
        data_hex = ''.join([f"{d:02X}" for d in data_chunk])
        file.write(f"{data_hex}\n")

print(f"Random data generated and saved to {output_file}.")
