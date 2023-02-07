# Simple Math Circom Circuit

This is the initial test of circom language

## Dependencies

* [`circom`](https://github.com/iden3/circom)
* [`node`](https://nodejs.org/en/)
* [`snarkjs`](https://github.com/iden3/snarkjs)

TLDR; Execution

```
make
make verify
```

1. Compiling Circuit
```
  circom simple-math.circom --r1cs --wasm --sym --c
```

--r1cs: generate r1cs file contains constraint system in binary
--wasm: generate _js file with wasm code and other files needed to generate witness
--sym: generate symbols file for debugging
--c: generate _cpp directory needed to compile C code to generate witness

-o: output directory

2. Computing Witness

```
node ./simple-math_js/generate_witness.js ./simple-math_js/simple-math.wasm input.json witness.wtns
```

OR

```
//In directory _cpp run
make

//Then run the application
./simple-math ../input.json witness.wtns 
```

Generates wtns file compatible with snarkjs

3. Proving Circuits

Use SnarkJS tool to generate and validate proof

```
//First start "powers of tau" ceremony
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

//Then contribute in ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v

//Now we have contributions in file pot12_0001.ptau
//Circuit-specific phase
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

//Generate zkey
snarkjs groth16 setup simple-math.r1cs pot12_final.ptau simple-math_0000.zkey

//Contribute to the phase 2 of the ceremony
snarkjs zkey contribute simple-math_0000.zkey simple-math_0001.zkey --name="1st Contributor Name" -v

//Export verification key
snarkjs zkey export verificationkey simple-math_0001.zkey verification_key.json

//Generating proof
snarkjs groth16 prove simple-math_0001.zkey witness.wtns proof.json public.json

//Verifying proof
snarkjs groth16 verify verification_key.json public.json proof.json


```

