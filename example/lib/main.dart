import 'package:clocks/clocks.dart';
import 'package:clocks/data_models/clock_time.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClockWidget(
          time: ClockTime(
            hour: 3,
            minute: 2,
            second: 20,
          ),
          onDrag: (updatedTime) {
            print(updatedTime.toStringTime);
          },
          onDragSpeed: 1,
        ),
      ),
    );
  }
}
