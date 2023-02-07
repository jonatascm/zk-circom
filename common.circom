pragma circom 2.0.0;

//This function check if value is zero
template IsZero() {
    signal input in;
    signal output out;
    signal inv;
    inv <-- in!=0 ? 1/in : 0;
    out <== -in*inv +1;
    in*out === 0;
}

//This function check if the values aren't equal
template NonEqual(){
  signal input in0;
  signal input in1;
  signal inv;
  //In circom there isn't constraint to difference (!==)
  //Then you need to make in this way:
  inv <-- 1/ (in0 - in1); 
  inv*(in0 - in1) === 1;
}


template Num2Bits(n) {
    signal input in;
    signal output out[n];
    var lc1=0;
    var e2=1;
    for (var i = 0; i<n; i++) {
        out[i] <-- (in >> i) & 1;
        out[i] * (out[i] -1 ) === 0;
        lc1 += out[i] * e2;
        e2 = e2+e2;
    }
    lc1 === in;
}