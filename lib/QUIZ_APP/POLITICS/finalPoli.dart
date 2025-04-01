import 'package:flutter/material.dart';
import 'package:firebasenew/QUIZ_APP/home.dart'; // Import home screen

class FinalScoreScreenPoli extends StatelessWidget {
  final int level1Score;
  final int level2Score;
  final int level3Score;

  FinalScoreScreenPoli({required this.level1Score, required this.level2Score, required this.level3Score});

  @override
  Widget build(BuildContext context) {
    int totalScore = level1Score + level2Score + level3Score;
    int totalQuestions = 3 * 3; // 3 levels, each with 3 questions

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Total Quiz Score"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "🎉 Quiz Completed! 🎉",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              "Your Final Score:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "$totalScore/$totalQuestions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizHome(email: '')));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Go to Home", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
