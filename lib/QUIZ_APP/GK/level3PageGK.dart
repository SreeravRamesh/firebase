import 'package:firebasenew/QUIZ_APP/GK/finalGK.dart';
import 'package:firebasenew/QUIZ_APP/SPORTS/finalSports.dart';
import 'package:flutter/material.dart';

class Level3CompletionScreenGK extends StatelessWidget {
  final int level1Score;
  final int level2Score;
  final int level3Score;

  Level3CompletionScreenGK({required this.level1Score, required this.level2Score, required this.level3Score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Level 3 Completed"),
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
            Text(
              "You completed Level 3!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Your Score: $level3Score/3",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalScoreScreenGK(
                      level1Score: level1Score,
                      level2Score: level2Score,
                      level3Score: level3Score,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("View Total Score", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
