/*
 * @Author: error: git config user.name && git config user.email & please set dead value or install git
 * @Date: 2022-05-27 23:17:16
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-05-29 08:32:47
 * @FilePath: /x_o_game/lib/utils/game_logic.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlength = 9;
  static final blocksize = 100.0;

  List<String>? board;

  static List<String>? intiGameBoard() =>
      List.generate(boardlength, (index) => Player.empty);

  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridsize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridsize + col] += score;
    if (row == col) scoreboard[2 * gridsize] += score;
    if (gridsize - 1 - col == row) scoreboard[2 * gridsize + 1] += score;

    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    ;

    return false;
  }
}
