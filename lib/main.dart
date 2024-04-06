import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolling Dice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: DiceScreen(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int _dice = 1;
  bool _rolling = false;

  void _rollDice() {
    if (!_rolling) {
      setState(() {
        _rolling = true;
      });

      // Generate random numbers between 1 and 6
      int randomNumber = Random().nextInt(6) + 1;

      // Update dice value after a short delay
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _dice = randomNumber;
          _rolling = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _rollDice,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rolling Dice by D22IT212 Prachi'),
        ),
        body: Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _rolling
                ? _buildRollingDice()
                : _buildStaticDice(),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticDice() {
    return Image.asset(
      '/Users/prachi/Documents/mini/ios/Runner/Assets.xcassets/dice$_dice.gif',
      key: ValueKey<int>(_dice),
      width: 200,
    );
  }

  Widget _buildRollingDice() {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 1, end: 6),
      duration: Duration(milliseconds: 500),
      builder: (BuildContext context, int index, Widget? child) {
        return Transform.rotate(
          angle: (pi / 180) * (360 / 6) * index,
          child: Image.asset(
            '/Users/prachi/Documents/mini/ios/Runner/Assets.xcassets/dice$index.gif',
            key: ValueKey<int>(index),
            width: 200,
          ),
        );
      },
    );
  }
}
