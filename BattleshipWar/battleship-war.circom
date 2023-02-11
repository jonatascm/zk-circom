pragma circom 2.0.0;

template BattleshipWar(n) {
  signal input solution[n][n];
  signal input map[n][n];
  signal output sigOut;

  signal constOne <-- 1;

  for(var i = 0; i < n; i++){
    for(var j = 0; j < n; j++){
      //Need to be in this way to check if one input is different from other
      //This mainly do: map - solution == 0, validating the battleship map
      constOne * (map[i][j] - solution[i][j]) === 0;
    }
  }
}

component main = BattleshipWar(5);