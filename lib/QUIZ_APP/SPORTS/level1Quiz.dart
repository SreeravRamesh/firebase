import 'package:firebasenew/QUIZ_APP/SPORTS/level1page.dart';
import 'package:firebasenew/QUIZ_APP/home.dart';
import 'package:flutter/material.dart';


class SportsQuizPage extends StatefulWidget {
  @override
  _SportsQuizPageState createState() => _SportsQuizPageState();
}

class _SportsQuizPageState extends State<SportsQuizPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = "";
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Who is the captain of the current Indian national cricket team?",
      "options": ["Virat Kohli", "Ravindra Jadeja", "Rohit Sharma", "K.L. Rahul"],
      "correct": "Rohit Sharma"
    },
    {
      "question": "Which country won the 2011 ICC Cricket World Cup?",
      "options": ["Australia", "India", "Pakistan", "Sri Lanka"],
      "correct": "India"
    },
    {
      "question": "How many players are there in a soccer team on the field?",
      "options": ["9", "10", "11", "12"],
      "correct": "11"
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LevelCompletionScreen(score: score, totalQuestions: questions.length),
        ),
      );
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer = selectedAnswersMap[currentQuestionIndex] ?? "";
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
        title: Text("Sports Quiz"),
      ),
      body: Container(decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/images/sports2.jpg"),fit: BoxFit.fill)),
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
                    onPressed: currentQuestionIndex == 0 ? null : previousQuestion,
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
