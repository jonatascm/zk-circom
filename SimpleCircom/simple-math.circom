pragma circom 2.0.0;

template SimpleMath() {
  signal input a;
  signal input b;
  signal output c;

  //Constraints.
  c <== a * b;
}

component main = SimpleMath();