SHELL = zsh

circom = battleship-war.circom
r1cs = battleship-war.r1cs
wasm = battleship-war_js/battleship-war.wasm
wit_gen = battleship-war_js/generate_witness.js
compile_outputs = battleship-war_js/witness_calculator.js $(r1cs) $(wasm) $(wit_gen)
pk = battleship-war.pk
vk = battleship-war.vk
ptau = battleship-war.ptau
keys = $(pk) $(vk)
p_input = battleship-war.input.json
wit = battleship-war.wtns
pf = battleship-war.pf.json
inst = battleship-war.inst.json
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
	rmdir battleship-war_js
