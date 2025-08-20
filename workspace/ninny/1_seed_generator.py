# Step 1 : generates a random seed of 32 bytes
# Step 2 : hash the previous 32-byte with SHA3-512 to split into rho (first 32 bytes) and sigma (last 32 bytes)

import secrets, hashlib #secrets is used to generate secure random numbers for managing secrets

def generate_rho_sigma():
    random = secrets.token_bytes(32) #Return a random byte string containing 32 number of bytes (PRNG)
    g = hashlib.sha3_512(random).digest() # use sha3_512 module, which products 64 bytes output
    rho, sigma = g[:32], g[32:] # Split into rho and sigma
    return rho, sigma # rho is for public matrix, sigma is for noise. These are then feed to SHAKE128

