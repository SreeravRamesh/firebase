import 'package:firebasenew/QUIZ_APP/SPORTS/level3page.dart';
import 'package:flutter/material.dart';

class Level3SportsPage extends StatefulWidget {
  @override
  _Level3SportsPageState createState() => _Level3SportsPageState();
}

class _Level3SportsPageState extends State<Level3SportsPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = "";
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which sport is known as the 'King of Sports'?",
      "options": ["Cricket", "Soccer", "Basketball", "Tennis"],
      "correct": "Soccer"
    },
    {
      "question": "Which country hosted the 2022 FIFA World Cup?",
      "options": ["USA", "Qatar", "France", "Brazil"],
      "correct": "Qatar"
    },
    {
      "question": "How many rings are there on the Olympic flag?",
      "options": ["3", "4", "5", "6"],
      "correct": "5"
    },
  ];

  Map<int, String> selectedAnswersMap = {};

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      selectedAnswersMap[currentQuestionIndex] = answer;
    });
  }
  void nextQuestion() {
    if (selectedAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an answer before proceeding!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = selectedAnswersMap[currentQuestionIndex] ?? "";
      });
    } else {
      calculateScore();

      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
      int level1Score = arguments["level1Score"] ?? 0;
      int level2Score = arguments["level2Score"] ?? 0;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Level3CompletionScreen(
            level1Score: level1Score,
            level2Score: level2Score,
            level3Score: score,
          ),
        ),
      );
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--; // Move back
        selectedAnswer = selectedAnswersMap[currentQuestionIndex] ?? ""; // Restore selection
      });
    }
  }



  void calculateScore() {
    int totalScore = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswersMap[i] == questions[i]["correct"]) {
        totalScore++;
      }
    }

    setState(() {
      score = totalScore;
    });

    showFinalResultDialog();
  }

  void showFinalResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quiz Completed!"),
          content: Text("Your total score for Level 3 is $score/${questions.length}."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetQuiz();
              },
              child: Text("Restart"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context); // Go back to home
              },
              child: Text("Go to Home"),
            ),
          ],
        );
      },
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswersMap.clear();
      selectedAnswer = "";
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Sports Quiz - Level 3"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${currentQuestionIndex + 1}: ${currentQuestion["question"]}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...currentQuestion["options"].map<Widget>((option) {
              bool isSelected = selectedAnswer == option;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.green : Colors.white,
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  onPressed: () => selectAnswer(option),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentQuestionIndex == 0 ? Colors.grey : Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    onPressed: currentQuestionIndex == 0 ? null : previousQuestion, // Disabled if first question
                    child: Text("Previous", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: nextQuestion,
                    child: Text(currentQuestionIndex < questions.length - 1 ? "Next" : "Finish", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
