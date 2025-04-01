import 'package:firebasenew/QUIZ_APP/GK/level2PageGK.dart';
import 'package:firebasenew/QUIZ_APP/SPORTS/level2page.dart';
import 'package:flutter/material.dart';

class Level2GKPage extends StatefulWidget {
  @override
  _Level2GKPageState createState() => _Level2GKPageState();
}

class _Level2GKPageState extends State<Level2GKPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = "";
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Who wrote the national anthem of India?",
      "options": ["Rabindranath Tagore", "Bankim Chandra Chattopadhyay", "Sarojini Naidu", "Subramania Bharati"],
      "correct": "Rabindranath Tagore"
    },
    {
      "question": "Which is the longest river in the world?",
      "options": ["Amazon River", "Nile River", "Ganges River", "Yangtze River"],
      "correct": "Nile River"
    },
    {
      "question": "What is the capital of Australia?",
      "options": ["Sydney", "Melbourne", "Perth", "Canberra"],
      "correct": "Canberra"
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
      int level1Score = ModalRoute.of(context)!.settings.arguments as int? ?? 0; // Get Level 1 Score

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Level2CompletionScreenGK(
            level1Score: level1Score,
            level2Score: score,
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
          content: Text("Your total score for Level 2 is $score/${questions.length}."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                resetQuiz(); // Restart quiz
              },
              child: Text("Restart"),
            ),
            TextButton(
              onPressed: () {
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
        title: Text("GK Quiz - Level 2"),
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
                    child: Text( currentQuestionIndex < questions.length - 1 ? "Next" : "Finish", style: TextStyle(fontSize: 18, color: Colors.white)),
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
