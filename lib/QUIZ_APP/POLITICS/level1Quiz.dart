import 'package:firebasenew/QUIZ_APP/home.dart';
import 'package:flutter/material.dart';

class PoliticsQuizPage extends StatefulWidget {
  @override
  _PoliticsQuizPage createState() => _PoliticsQuizPage();
}

class _PoliticsQuizPage extends State<PoliticsQuizPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = "";
  int score = 0;

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Who is the current prime minister of india?",
      "options": ["Narendra Modi", "Rahul Gandhi", "Suresh Nagarkoti", "Raja Lakshmi"],
      "correct": "Narendra Modi"
    },
    {
      "question": "Who is the president of India",
      "options": ["Narendra Modi", "Droupathi Murmu", "Rakesh Menon", "Vijitha Shenoy"],
      "correct": "Droupathi Murmu"
    },
    {
      "question": "Who is the chief minister of kerala?",
      "options": ["Kodiyer Balakrishnan", "Suresh Gopi", "Umman Chandi", "Pinarayi Vijayan"],
      "correct": "Pinarayi Vijayan"
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
        currentQuestionIndex++; // Move forward
        selectedAnswer = selectedAnswersMap[currentQuestionIndex + 1] ?? ""; // Restore selection if available
      });
    } else {
      calculateScore();
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

    showResultDialog();
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Quiz Completed!"),
          content: Text("Your total score is $score/${questions.length}."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                resetQuiz(); // Restart quiz
              },
              child: Text("Restart"),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizHome(email: '')));
            }, child: Text("Go to Home"))
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
        title: Text("Politics Quiz"),
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("Assets/images/politics2.jpg"),fit: BoxFit.fill)),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    onPressed: nextQuestion,
                    child: Text(
                      currentQuestionIndex < questions.length - 1 ? "Next" : "Finish",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
