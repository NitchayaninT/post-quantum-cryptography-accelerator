// Step 2 : hash the previous 32-byte with SHA3-512 to split into rho (first 32 bytes) and sigma (last 32 bytes)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
//#include <openssl/evp.h> //debian only

