SHELL = zsh

circom = simple-math.circom
r1cs = simple-math.r1cs
wasm = simple-math_js/simple-math.wasm
wit_gen = simple-math_js/generate_witness.js
compile_outputs = simple-math_js/witness_calculator.js $(r1cs) $(wasm) $(wit_gen)
pk = simple-math.pk
vk = simple-math.vk
ptau = simple-math.ptau
keys = $(pk) $(vk)
p_input = simple-math.input.json
wit = simple-math.wtns
pf = simple-math.pf.json
inst = simple-math.inst.json
prove_outputs = $(pf) $(inst)

all: verify

$(compile_outputs): $(circom)
	circom $< --r1cs --wasm

$(ptau):
	snarkjs powersoftau new bn128 12 tmp.ptau
	snarkjs powersoftau prepare phase2 tmp.ptau $(ptau)
	rm tmp.ptau

$(keys): $(ptau) $(r1cs)
	snarkjs groth16 setup $(r1cs) $(ptau) $(pk)
	snarkjs zkey export verificationkey $(pk) $(vk)

$(wit): $(p_input) $(wasm) $(wit_gen)
	node $(wit_gen) $(wasm) $(p_input) $@

$(prove_outputs): $(wit) $(pk)
	snarkjs groth16 prove $(pk) $(wit) $(pf) $(inst)

.PHONY = verify clean

verify: $(pf) $(inst) $(vk)
	snarkjs groth16 verify $(vk) $(inst) $(pf)

clean:
	rm -f $(compile_outputs) $(ptau) $(keys) $(wit) $(prove_outputs)
	rmdir simple-math_js
