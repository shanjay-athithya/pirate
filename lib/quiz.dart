import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List questions = [
    {"q": "Flutter is developed by Google?", "a": true},
    {"q": "Dart is used in Flutter?", "a": true},
    {"q": "Flutter is only for Android?", "a": false}
  ];
  
  int index = 0, score = 0, seconds = 10;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds > 0) setState(() => seconds--);
      else nextQuestion();
    });
  }

  void checkAnswer(bool answer) {
    if (questions[index]['a'] == answer) score++;
    nextQuestion();
  }

  void nextQuestion() {
    timer.cancel();
    if (index < questions.length - 1) {
      setState(() {
        index++;
        seconds = 10;
      });
      startTimer();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Quiz Over"),
          content: Text("Score: $score / ${questions.length}"),
          actions: [TextButton(onPressed: resetQuiz, child: Text("Retry"))],
        ),
      );
    }
  }

  void resetQuiz() {
    setState(() {
      index = 0;
      score = 0;
      seconds = 10;
    });
    Navigator.pop(context);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App"), backgroundColor: Colors.redAccent),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Time Left: $seconds", style: TextStyle(fontSize: 20, color: Colors.redAccent)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(questions[index]['q'], style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => checkAnswer(true), child: Text("True")),
              ElevatedButton(onPressed: () => checkAnswer(false), child: Text("False"))
            ],
          )
        ],
      ),
    );
  }
}
