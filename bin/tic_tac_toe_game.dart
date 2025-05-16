import 'board_brain.dart';

BoardBrain boardBrain = BoardBrain();

void main() {
  buildGameHead(
    title: '***************Lets play tic-tac-toe game!***************',
  );
  buildGameBody();
}

void buildGameHead({required String title}) {
  print(title);
  print('_________________________________________________________');
}

buildGameBody() {
  //display the board UI before answer
  //it will look like this:
  // |__1__|__2__|__3__|
  // |__4__|__5__|__6__|
  // |__7__|__8__|__9__|
  //or this (depends on where you put X or O)
  // |__X__|__2__|__X__|
  // |__4__|__O__|__6__|
  // |__7__|__8__|__9__|

  buildBoardUi();

  boardBrain.askForNumber();
}

void buildBoardUi() {
  print('BOARD:');

  final formatted = boardBrain.formattedSquareContent; // calculate once

  print('''
  |__${formatted[0]}__|__${formatted[1]}__|__${formatted[2]}__|
  |__${formatted[3]}__|__${formatted[4]}__|__${formatted[5]}__|
  |__${formatted[6]}__|__${formatted[7]}__|__${formatted[8]}__|
''');
}
