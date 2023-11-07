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
          size: const Size(250, 250),
          time: ClockTime(
            hour: 9,
            minute: 20,
            second: 14,
          ),
          pointyNeedle: true,
          onDrag: (updatedTime) {
            print(updatedTime.toStringTime);
          },
          showHoursLabels: false,
          clockThickness: 20,
          needleThickness: 20,
          dragSpeed: 1,
          color: Colors.black,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
