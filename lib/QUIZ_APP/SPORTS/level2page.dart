import 'package:firebasenew/QUIZ_APP/SPORTS/level2Quiz.dart';
import 'package:firebasenew/QUIZ_APP/SPORTS/level3Quiz.dart';
import 'package:flutter/material.dart';

class Level2CompletionScreen extends StatelessWidget {
  final int level1Score;
  final int level2Score;

  Level2CompletionScreen({required this.level1Score, required this.level2Score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Level 2 Completed"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "🎉 Congratulations! 🎉",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text("You completed Level 2!", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Your Score: $level2Score/3", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Level3SportsPage(),
                    settings: RouteSettings(arguments: {
                      "level1Score": level1Score,
                      "level2Score": level2Score,
                    }),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Proceed to Level 3", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
