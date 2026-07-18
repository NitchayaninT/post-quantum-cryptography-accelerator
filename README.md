# Kyber768 Post-Quantum Cryptographic Accelerator on FPGA
![HDL](https://img.shields.io/badge/HDL-SystemVerilog-blue) ![Vivado](https://img.shields.io/badge/Vivado-2025.1-red) 

## Overview

This undergraduate senior project presents a hardware-oriented implementation of **Kyber768**, a lattice-based post-quantum Key Encapsulation Mechanism originally selected by NIST and later standardized as **ML-KEM-768**.

The accelerator is implemented in **SystemVerilog** and evaluated using the **Xilinx Vivado Design Suite**. The project focuses on accelerating the encapsulation and decapsulation operations of Kyber768 through dedicated hardware modules for polynomial arithmetic, hashing, encoding, decoding, compression, and memory management.

The design was verified through functional simulation and evaluated using synthesis reports for latency, clock-cycle count, and FPGA resource utilization.

> **Note:** The project covers simulation and synthesis only. The design was not physically deployed on an FPGA development board.

---

## Key Features

* Hardware implementation of Kyber768 encapsulation and decapsulation
* Modular polynomial arithmetic architecture
* Number Theoretic Transform and inverse NTT processing
* Pointwise Montgomery multiplication
* SHA-3 and SHAKE-based hash operations
* BRAM-based storage for polynomial and intermediate data
* Resource utilization analysis using Vivado synthesis
* Clock-cycle and computation-time evaluation
* Simulation-based verification using predefined test vectors

---

## Project Goals

* Implement Kyber768 encapsulation and decapsulation cryptographic operations in hardware
* Reduce the latency of encapsulation and decapsulation
* Evaluate the hardware cost of the proposed architecture
* Analyze FPGA resource utilization
* Verify that encapsulation and decapsulation generate matching shared secrets

---

## Project Scope

The project implements the following Kyber768 operations:

* Encapsulation
* Decapsulation
* Polynomial arithmetic
* Hashing and extendable-output functions
* Compression, decompression, encoding, and decoding
* Intermediate data storage and control

Hardware key generation is outside the scope of the project. The public key, secret key, random input, and reference values are provided through the simulation testbenches.

---

## What Is Kyber768?

Kyber768 is a post-quantum Key Encapsulation Mechanism designed to allow two communicating parties to establish a shared secret securely.

Unlike a conventional data-encryption algorithm, Kyber768 does not directly encrypt application data. Instead, it generates a shared secret that can later be used with a symmetric encryption algorithm, such as AES to protect communication.

Kyber768 is designed to remain secure against attacks from both classical and quantum computers.

---

## Kyber768 Workflow

### Encapsulation

1. Receives the recipient's public key and random input.
2. Generates and processes the message and performs hashing.
3. Performs polynomial sampling, NTT operations, multiplication, addition, and compression.
4. Produces a ciphertext.
5. Derives a shared secret.

### Decapsulation

1. Receives the ciphertext and secret key.
2. Decompresses and decodes the ciphertext.
3. Performs inverse polynomial operations to recover the message.
4. Reconstructs the expected ciphertext and verifies its validity.
5. Produces the corresponding shared secret.

Successful verification is confirmed when the encapsulation and decapsulation modules produce the same shared secret.

---

## System Architecture

![Kyber768 Encryption and Decryption Flowchart](/pictures/Kyber768_Flowchart.png)

The architecture is divided into preprocessing, polynomial computation, encoding, hashing, memory, and post-processing modules.

The encapsulation and decapsulation datapaths reuse several arithmetic components to reduce duplicated hardware resources.

---

### Memory and Hash Architecture

![RAM and Hash Controller Architecture](/pictures/RAM_Architecture.jpeg)

The `main_computation` module uses 15 dual-port RAMs to store polynomial data such as \(A^T\), \(t/s\), and \(r/u'\). These memories are shared by the NTT, pointwise Montgomery multiplication, and inverse NTT modules through controlled read and write access.

The `hash_controller` stores input bytes in dedicated RAM and constructs rate-sized blocks according to the selected SHA-3 or SHAKE operation. These blocks are then processed by the sponge controller (hashing core) through the absorb, permutation, and squeeze stages.

---

## Main Hardware Modules

### Pre-Encryption

Prepares the public key, message, random input, hash values, and polynomial data required by the encapsulation datapath.

### Pre-Decryption

Parses the secret key and ciphertext and prepares the polynomial data required by the decapsulation datapath.

### Number Theoretic Transform

Transforms polynomial coefficients into the NTT domain to support efficient polynomial multiplication.

### Pointwise Montgomery Multiplication

Performs coefficient-wise multiplication in the NTT domain using Montgomery modular arithmetic.

### Inverse Number Theoretic Transform

Converts polynomial results from the NTT domain back to the standard coefficient domain.

### Addition

Performs modular polynomial addition during encapsulation.

### Subtraction

Performs modular polynomial subtraction during decapsulation to recover the encoded message polynomial.

### Reduction

Reduces polynomial coefficients modulo the Kyber modulus.

The reduction module supports operations required by both encapsulation and decapsulation.

### Compression and Encoding

Compresses polynomial coefficients to reduce the ciphertext size and encodes the resulting values into byte-oriented output data.

### Decompression and Decoding

Reconstructs polynomial coefficient representations from the ciphertext and converts the recovered polynomial into message bits.

### Hash Controller

Controls SHA-3 and SHAKE operations with variable input and output sizes using rate-based processing.

### BRAM Controller

Controls the storage and retrieval of polynomial coefficients, intermediate values, keys, and ciphertext data using block RAM.

### Post-Encryption

Formats the ciphertext and derives the final shared secret produced by encapsulation.

### Post-Decryption

Performs ciphertext verification and derives either the valid shared secret or the fallback shared secret required by the Kyber decapsulation procedure.

---

## Repository Structure

```text
kyber768-accelerator-on-fpga/
├── archive/
│   ├── old_modules/
│   ├── sha/
│   └── shake/
├── constraint/
├── experimental/
├── hdl/
│   ├── decryption/
│   │   └── pre_decryption/
│   ├── encryption/
│   │   ├── main_computation/
│   │   └── pre_encryption/
│   └── shared/
│       └── hash/
│           └── permutation/
├── pictures/
├── presentations/
├── reports/
|   └── decapsulation /
|   └── encapsulation /
│   └── main_computation/
├── sim_results/
│   └── hash/
├── test/
│   ├── hash/
│   └── main_computation/
└── README.md
```

---

## Requirements

* Xilinx Vivado Design Suite
* SystemVerilog-compatible simulator

---

## Simulation

1. Open the project in Vivado.
2. Add the SystemVerilog source files.
3. Add the required simulation testbench (located in test/)
4. Select the encryption or decryption top module.
5. Run behavioral simulation.
6. Observe the completion signal, ciphertext, and shared-secret outputs.
7. Compare the encapsulation and decapsulation shared secrets.

Example simulation testbench may include:

```text
├── test/
|   ├── encapsulation_tb.sv
|   ├── decapsulation_tb.sv
```
---

## Synthesis and Resource Evaluation

The design can be synthesized in Vivado to evaluate :

* Registers
* Block RAM
* DSP slices
* Clock-cycle count
* Estimated computation time

Computation time formula

```text
Computation time = Number of clock cycles / Clock frequency
```

For example, at a target clock frequency of 100 MHz, one clock cycle corresponds to 10 ns.

Detailed synthesis results are available in the project report or the `reports/` directory.

---

## Verification

The design is verified through simulation using predefined Kyber768 input values, expected ciphertext values and expected shared-secret values.

The main functional verification condition is:

```text
Encapsulation shared secret == Decapsulation shared secret
```

---

## Limitations

* Key generation is not implemented as a hardware module.
* The design was evaluated through simulation and synthesis only.
* Physical FPGA deployment and on-board testing were not performed.
* The implementation may not include all side-channel countermeasures required for production use.
* The design is intended for academic and research purposes.

---

## Future Improvements

Potential future work includes:

* Implementing hardware key generation
* Deploying the design on a physical FPGA board
* Improving module sharing and scheduling
* Increasing pipelining and parallel processing
* Reducing BRAM and logic utilization
* Adding side-channel attack countermeasures
* Supporting additional ML-KEM security levels
* Integrating the accelerator with a processor or communication system

---

## Authors

Developed as an undergraduate senior project in Computer Engineering.

### Members
1. Pakin Panawattanakul
2. Nitchayanin Thamkunanon
3. Panupong Sangaphunchai

---

## References

### Standards and Documentation

- National Institute of Standards and Technology,  
  [*FIPS 203: Module-Lattice-Based Key-Encapsulation Mechanism Standard*](https://doi.org/10.6028/NIST.FIPS.203)

- CRYSTALS-Kyber Team,  
  [*CRYSTALS-Kyber Reference Implementation*](https://github.com/pq-crystals/kyber)

- AMD Xilinx,  
  *Vivado Design Suite Documentation*

### Performance Comparison References

The FPGA resource utilization and computation time of this project were compared with the following hardware implementations:

1. Y. Huang, M. Huang, Z. Lei, and J. Wu,  
   “A Pure Hardware Implementation of CRYSTALS-KYBER PQC Algorithm through Resource Reuse,”  
   *IEICE Electronics Express*, vol. 17, 2020.  
   [https://doi.org/10.1587/elex.17.20200234](https://doi.org/10.1587/elex.17.20200234)

2. Y. Xing and S. Li,  
   “A Compact Hardware Implementation of CCA-Secure Key Exchange Mechanism CRYSTALS-KYBER on FPGA,”  
   *IACR Transactions on Cryptographic Hardware and Embedded Systems*, vol. 2021, no. 2, pp. 328–356, 2021.  
   [https://doi.org/10.46586/tches.v2021.i2.328-356](https://doi.org/10.46586/tches.v2021.i2.328-356)

3. H. Li, Y. Tang, Z. Que, and J. Zhang,  
   “FPGA Accelerated Post-Quantum Cryptography,”  
   *IEEE Transactions on Nanotechnology*, vol. 21, pp. 685–691, 2022.  
   [https://doi.org/10.1109/TNANO.2022.3217802](https://doi.org/10.1109/TNANO.2022.3217802)

---

## Disclaimer

This project is an academic hardware implementation intended for research and educational purposes. It has not been independently audited and should not be used as a production cryptographic implementation.
