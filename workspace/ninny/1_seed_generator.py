# Step 1 : generates a random seed of 32 bytes
# Step 2 : hash the previous 32-byte with SHA3-512 to split into rho (first 32 bytes) and sigma (last 32 bytes)

import secrets, hashlib #secrets is used to generate secure random numbers for managing secrets
from bitstring import BitArray  

# gets seed and coins
def generate_rho_sigma():
    random = secrets.token_bytes(32) #Return a random byte string containing 32 number of bytes (PRNG)
    g = hashlib.sha3_512(random).digest() # use sha3_512 module, which products 64 bytes output
    rho, sigma = g[:32], g[32:] # Split into rho and sigma
    return rho, sigma # rho is for public matrix, sigma is for noise. These are then feed to SHAKE128

# generate shake128
def shake128_hash(bytes_data, output_len):
    shake128 = hashlib.shake_128()
    shake128.update(BitArray(hex=bytes_data).bin)
    # Generate a hash of the desired length
    hash_output = shake128.digest(output_len)
    print("SHAKE128 Hash:", hash_output.hex())
    print("Bytes Count:", len(hash_output.hex()))
    return hash_output

# generate shake256 (uses in Kyber1024 only to gen noise)
def shake256_hash(bytes_data, output_len):
    shake256 = hashlib.shake_128()
    shake256.update(BitArray(hex=bytes_data).bin)
    # Generate a hash of the desired length
    hash_output = shake256.digest(output_len)
    print("SHAKE256 Hash:", hash_output.hex())
    print("Bytes Count:", len(hash_output.hex()))
    return hash_output

# MAIN
rho, sigma = generate_rho_sigma()
# Generate A 
public_matrix_bytes = shake128_hash(rho,32)
# Generate noise char
noise_bytes = shake256_hash(sigma,32)