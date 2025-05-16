import 'dart:io';

enum BoardSquareContent { x, o, empty }

enum PlayerTurn { x, o }

class BoardBrain {
  int turnCount = 1;
  bool isGameEnd = false;
  //A player wins the game by placing 3 Xs or Os in one of the following sequences...
  List<String> wins = ['012', '048', '036', '147', '246', '258', '345', '678'];
  //Player X always starts the game
  PlayerTurn playerTurn = PlayerTurn.x;
  //all squares are empty before starting the game
  List<BoardSquareContent> squaresContent = List.filled(
    9,
    BoardSquareContent.empty,
  );

  //formatted name to be displayed in game texts: x >> X, o >> O
  String get formattedPlayerName => playerTurn.name.toUpperCase();

  //Player X Sequence in each time X choose a number it will be added to the string Same to O
  //The initial value is an empty string before the player chooses anything
  String xSeq = '';
  String oSeq = '';
  int input = 0;
  //Formatted square values to be shown on the board (as 1–9, X, or O)
  setToInitials() {
    squaresContent = List.filled(9, BoardSquareContent.empty);
    xSeq = '';
    oSeq = '';
    input = 0;
    playerTurn = PlayerTurn.x;
    turnCount = 1;
    isGameEnd = false;
  }

  List<String> get formattedSquareContent {
    List<String> formattedContent = [];
    for (int i = 0; i < squaresContent.length; i++) {
      switch (squaresContent[i]) {
        case BoardSquareContent.x:
          formattedContent.add('X');
          break;
        case BoardSquareContent.o:
          formattedContent.add('O');
          break;
        case BoardSquareContent.empty:
          formattedContent.add(
            '${i + 1}',
          ); //i + 1 because we won't display 0 1 2 ..8 we will display 1 2 3 .. 9
          break;
      }
    }
    return formattedContent;
  }

  switchTurn() {
    playerTurn = playerTurn == PlayerTurn.x ? PlayerTurn.o : PlayerTurn.x;
  }

  int getUserInput() {
    try {
      print('Your answer:');
      String? stringInput =
          stdin
              .readLineSync(); //if the user entered any symbol it will throw an exception
      //if user did not enter anything it will be considered as 0 and 0 is invalid value
      int input = int.parse(
        (stringInput == null || stringInput == '') ? '0' : stringInput,
      );
      //handle errors and Exceptions: check if the input in the range [1 - 9]
      if (input <= 0 || input >= 10) {
        throw Exception();
      }
      return input;
    } catch (e) {
      print('You have to enter a value between 1 and 9!!');
      input = getUserInput();
      return input;
    }
  }

  void askForNumber() {
    print('it\'s ($formattedPlayerName) turn, Choose a square (1–9):');
    //the user will choose from 1 to 9 but we will store it as 0 to 8 that why we put getUserinput - 1
    int input = getUserInput() - 1;

    //if the square is empty (does not contain X or O)
    if (squaresContent[input] == BoardSquareContent.empty) {
      //then check the player turn if its X turn
      if (playerTurn == PlayerTurn.x) {
        // change the content from empty to X
        squaresContent[input] = BoardSquareContent.x;
        //and add the number player choose to the sequence
        xSeq = '$xSeq$input';
        checkWinOrNot(xSeq);
      } else {
        //else if its O turn same logic as X
        squaresContent[input] = BoardSquareContent.o;
        oSeq = '$oSeq$input';
        checkWinOrNot(oSeq);
      }
      //display the board
      printBoard();
      //switch the turn after player choice
      switchTurn();
      //increase turn by one because the player played his turn.
      turnCount = turnCount + 1;
      continueGame();
    } else {
      //We don’t switch turns or increase the count because the player hasn’t made a valid move yet
      print('Please choose an empty square!');
      continueGame();
    }
  }

  void printBoard() {
    print('BOARD AFTER YOUR $formattedPlayerName CHOICE:');
    final formatted = formattedSquareContent; // calculate once

    print('''
  |__${formatted[0]}__|__${formatted[1]}__|__${formatted[2]}__|
  |__${formatted[3]}__|__${formatted[4]}__|__${formatted[5]}__|
  |__${formatted[6]}__|__${formatted[7]}__|__${formatted[8]}__|
''');
  }

  int countMatchingDigits(String a, String b) {
    // Convert strings to sets of digits
    final digitsA = a.split('').toSet();
    final digitsB = b.split('').toSet();

    // Find intersection of both sets
    final commonDigits = digitsA.intersection(digitsB);

    // Return the number of matching digits
    return commonDigits.length;
  }

  void continueGame() {
    if (isGameEnd) {
      print('The game has ended!');
      askToRestartTheGame();
    } else {
      if (turnCount > 9) {
        //logic if there is a winner or not
        print('Nobody won, it\'s a draw!');
        askToRestartTheGame();
      } else {
        //if there is an empty square left then ask again...
        askForNumber();
      }
    }
  }

  void checkWinOrNot(String seq) {
    //if the sequence consists of 3 or more (the user needs 3 places to win) then check
    if (seq.length > 2) {
      //if there are matching digits in the players sequence and the win sequences
      for (String win in wins) {
        int matchingDigits = countMatchingDigits(seq, win);
        //if the matching digits reached to 3 then the player win the game
        if (matchingDigits > 2) {
          //print player win and end the game

          print('''
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║                    🎉🎉  CONGRATULATIONS! 🎉🎉                     ║
║                                                                    ║
║                       Player $formattedPlayerName wins the game! 🏆                   ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
''');

          isGameEnd = true;
          //get out of the loop, don't search in the remaining win sequences because you've already won the game
          break;
        }
      }
    }
  }

  void askToRestartTheGame() {
    print('Do you want to restart the game?y/n');
    String? stringInput = stdin.readLineSync();
    if (stringInput == 'y') {
      restart();
    } else if (stringInput == 'n') {
      return;
    }
  }

  restart() {
    setToInitials();
    printBoard();
    askForNumber();
  }
}
