import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: Text('Dicee App',style:TextStyle(
        fontFamily: 'Lobster',
      )),
      backgroundColor: Colors.red,
    ),
    body: FrontPage(),
  )));
}

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = new AudioPlayer();

  int leftDice = 1;
  int rightDice = 1;

  bool isPlaying = false;
  bool isPaused =false;

  void diceSound() async {
    if (isPlaying) {
      audioPlayer.stop();
      audioPlayer = await audioCache.play('dicerollsound.mp3');

    } else {
      audioPlayer = await audioCache.play('dicerollsound.mp3');
    }
  }

  void rollDice() {
    setState(() {
      leftDice = Random().nextInt(6) + 1;
      rightDice = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/newbackground.png'),
            fit: BoxFit.cover,
          )),
        ),
        Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(25.0),
                child: Image.asset('assets/diceeLogo.png'),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.all(25.0),
              child: Image.asset('assets/dice$leftDice.png'),
            ),
            Container(
              margin: EdgeInsets.all(25.0),
              child: Image.asset('assets/dice$rightDice.png'),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: EdgeInsets.all(25.0),
                child: ElevatedButton(
                    onPressed: () {
                      rollDice();
                      diceSound();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    child: Text(' Roll',style:TextStyle(
                      fontFamily: 'Lobster',
                    ))))
          ]),
        ])
      ],
    );
  }
}
