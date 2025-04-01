import 'package:firebasenew/QUIZ_APP/POLITICS/PoiticsLevel1Page.dart';
import 'package:firebasenew/QUIZ_APP/home.dart';
import 'package:flutter/material.dart';



class PoliticsQuizPage extends StatefulWidget {
  @override
  _PoliticsQuizPageState createState() => _PoliticsQuizPageState();
}

class _PoliticsQuizPageState extends State<PoliticsQuizPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = "";
  int score = 0;

  final List<Map<String, dynamic>> level1Questions = [
    {
      "question": "Who is the current Prime Minister of India?",
      "options": ["Narendra Modi", "Rahul Gandhi", "Amit Shah", "Arvind Kejriwal"],
      "correct": "Narendra Modi"
    },
    {
      "question": "Which international organization is responsible for maintaining global peace and security?",
      "options": ["United Nations", "World Bank", "NATO", "IMF"],
      "correct": "United Nations"
    },
    {
      "question": "How many members are there in the Lok Sabha of India?",
      "options": ["450", "545", "600", "543"],
      "correct": "543"
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

    if (currentQuestionIndex < level1Questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = selectedAnswersMap[currentQuestionIndex] ?? "";
      });
    } else {
      calculateScore();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LevelCompletionScreenPlitics(score: score, totalQuestions: level1Questions.length),
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
    for (int i = 0; i < level1Questions.length; i++) {
      if (selectedAnswersMap[i] == level1Questions[i]["correct"]) {
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
          content: Text("Your total score is $score/${level1Questions.length}."),
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
    final currentQuestion = level1Questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Politics Quiz"),
      ),
      body: Container(decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/images/politics2.jpg"),fit: BoxFit.fill)),
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
                      currentQuestionIndex < level1Questions.length - 1 ? "Next" : "Finish",
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
