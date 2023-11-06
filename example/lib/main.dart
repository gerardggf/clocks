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
      body: Column(
        children: [
          Expanded(
            child: ClockWidget(
              time: ClockTime(
                hour: 22,
                minute: 30,
                second: 22,
              ),
              color: Colors.black,
              backgroundColor: Colors.white,
              pointyNeedle: true,
              needleWidth: 4,
              showHoursLabel: true,
            ),
          ),
        ],
      ),
    );
  }
}
