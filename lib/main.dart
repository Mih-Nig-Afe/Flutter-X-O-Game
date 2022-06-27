/*
 * @Author: Mihretab Nigatu
 * @Date: 2022-05-27 21:56:56
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-05-29 09:43:39
 * @Description: Tic Tac Toe Game sample with flutter for training
 */
import 'package:flutter/material.dart';
import 'package:x_o_game/ui/theme/color.dart';
import 'package:x_o_game/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Tic Tac Toe';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastvalue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.intiGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${lastvalue}'s turn".toUpperCase(),
              style: TextStyle(
                color: Color.fromARGB(255, 0, 251, 255),
                fontSize: 58,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: boardwidth,
              height: boardwidth,
              child: GridView.count(
                crossAxisCount: Game.boardlength ~/ 3,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlength, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastvalue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastvalue, index, scoreboard, 3);

                                if (gameOver) {
                                  result = "$lastvalue Wins";
                                } else if (!gameOver && turn == 9) {
                                  result =
                                      "Draw! No One Winner; Try next round ";
                                  gameOver = true;
                                }
                                if (lastvalue == "X")
                                  lastvalue = "O";
                                else
                                  lastvalue = "X";
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocksize,
                      height: Game.blocksize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Color.fromARGB(255, 255, 0, 0)
                                : Color.fromARGB(255, 238, 255, 0),
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 54.0),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.intiGameBoard();
                  lastvalue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              label: Text("Play Again"),
            ),
          ],
        ));
  }
}
