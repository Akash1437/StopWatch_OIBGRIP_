// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchScreen(),
    );
  }
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  String hoursString = "00", minuteString = "00", secondString = "00";

  int hours = 0;
  int minutes = 00;
  int seconds = 00;
  bool isTimerRunning = false;
  //IsRestartButtonVisible = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          // ignore: prefer_interpolation_to_compose_strings
          secondString = "0" + secondString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0$minuteString";
        }
      } else {
        _startHour();
      }
    });
  }

  void _startHour() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondString = "00";
      minuteString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0$hoursString";
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondString = "00";
      minuteString = "00";
      hoursString = "00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 87, 132, 231),
        //backgroundColor: Colors.transparent,
        elevation: 0,

        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          'StopWatch',
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black, // shadow color
                offset: Offset(1.0, 1.0),
              ),
            ],
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 39, 145, 232),
            Color.fromARGB(255, 102, 126, 138)
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hoursString:$minuteString:$secondString",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.white,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color.fromARGB(255, 0, 56, 84),
                      elevation: 18,
                    ),
                    onPressed: () {
                      startTimer();
                    },
                    child: Text("play")),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blueGrey,
                      elevation: 18,
                    ),
                    onPressed: () {
                      pauseTimer();
                    },
                    child: Text("pause")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blueGrey,
                  elevation: 18,
                ),
                onPressed: () {
                  resetTimer();
                },
                child: Text("Restart")),
          ],
        ),
      ),
    );
  }
}
