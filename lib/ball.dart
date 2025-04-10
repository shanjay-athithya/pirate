import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(BouncingBallApp());

class BouncingBallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ball Animation',
      home: BouncingBallScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BouncingBallScreen extends StatefulWidget {
  @override
  _BouncingBallScreenState createState() => _BouncingBallScreenState();
}

class _BouncingBallScreenState extends State<BouncingBallScreen> {
  double _top = 100.0;
  bool _goingDown = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _top = _goingDown ? 400.0 : 100.0;
        _goingDown = !_goingDown;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _top,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Ball(),
          ),
        ],
      ),
    );
  }
}

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
    );
  }
}
