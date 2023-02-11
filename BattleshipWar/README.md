# Battleship War Circom Circuit

This project is a game where the objective is to find where the battleship is in the map.

Given a map as example (5x5):
<br>[0,1,1,0,0,<br>
&nbsp;&nbsp;0,0,0,2,0,<br>
&nbsp;&nbsp;0,0,0,2,0,<br>
&nbsp;&nbsp;0,0,0,2,0,<br>
&nbsp;&nbsp;3,3,0,0,0]

The battleships are: 1, 2 and 3.
You objective is to send a map with same position of the ships.

## Dependencies

* [`circom`](https://github.com/iden3/circom)
* [`node`](https://nodejs.org/en/)
* [`snarkjs`](https://github.com/iden3/snarkjs)

Run already solved example

```
make
make verify
```


In `battleship-war.input.json` folder you can change the inputs to make another map and solve it
