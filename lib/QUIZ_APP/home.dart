import 'package:firebasenew/QUIZ_APP/GK/level1QuizGK.dart';
import 'package:firebasenew/QUIZ_APP/MOVIE/level1QuizMov.dart';
import 'package:firebasenew/QUIZ_APP/POLITICS/level1PoliQuiz.dart';
import 'package:firebasenew/QUIZ_APP/SPORTS/level1Quiz.dart';
import 'package:flutter/material.dart';

class QuizHome extends StatelessWidget {
  final String email;
  QuizHome({super.key, required this.email});

  final List<Widget> pages = [
    SportsQuizPage(),
    PoliticsQuizPage(),
    MovieQuizPage(),
    GKQuizPage(),
  ];

  var image=["Assets/images/quizSports.jpg","Assets/images/quizPolitics.jpg",
  "Assets/images/quizmovie.jpg","Assets/images/quizGK.jpg"];

  var text=["SPORTS","POLITICS","MOVIES","GK"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QUIZ APP"),backgroundColor: Colors.blue,
      bottom: AppBar(title: Container(
        child: Text("Select the Mode",style: TextStyle(fontSize: 30),),),),
      ),
      body:
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pages[index]),
                    );
                  },
                  child: Card(color: Colors.blue[200],
                    child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,),
                            Image(image: AssetImage(image[index]),height: 290,width: 290,),
                           SizedBox(height: 10,),
                           Text(text[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          ],
                        ),

                    ),
                  ),
                );
              },itemCount: text.length,),

    );
  }
}
