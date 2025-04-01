import 'package:firebasenew/QUIZ_APP/POLITICS/level2QuizPoli.dart';
import 'package:firebasenew/QUIZ_APP/SPORTS/level2Quiz.dart';
import 'package:flutter/material.dart';

class LevelCompletionScreenPlitics extends StatelessWidget {
  final int score;
  final int totalQuestions;

  LevelCompletionScreenPlitics({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Level 1 Completed"),
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
              "You completed Level 1!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Your Score: $score/$totalQuestions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Level2PoliticsPage(),
                    settings: RouteSettings(arguments: score),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Proceed to Level 2", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
