# Tic-Tac-Toe Game (Console)

Welcome to this simple **Tic-Tac-Toe** game implemented in **Dart** for the console!  
It's a fun two-player game where you play against another human by taking turns placing `X` or `O` on a 3x3 board.

---


## How to Play

1. Run the game.
2. The board is displayed with numbers 1 to 9 representing empty squares.
3. Players take turns entering a number to place their mark (`X` or `O`) in that square (X always starts).
4. The board updates after each turn showing `X`, `O`, or the square number if empty.
5. The game ends when a player wins by placing three of their marks in a row, column, or diagonal, or when all squares are filled (draw).
6. After the game ends, you can choose to restart or exit.

---

## Getting Started

### Prerequisites

- Dart SDK installed on your machine.  
  You can download it from [https://dart.dev/get-dart](https://dart.dev/get-dart)
- or you can run the code in [this](https://www.tutorialspoint.com/execute_dart_online.php) dart compiler, it supports dart:io
//important note: if you want to use the compiler:
- copy the 2 files from bin folder to the compiler (board_brain.dart first)
- delete this line (import 'board_brain.dart';) from tic_tac_toe_game.dart file
- excecute the code
  
### Running the Game

1. Clone the repository or copy the code files.
2. Open a terminal and navigate to the folder containing the code.
3. Run the game with:

   ```bash
   dart run bin\tic_tac_toe_game.dart
