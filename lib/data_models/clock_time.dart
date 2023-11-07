// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import '../clocks.dart';

///Time to be displayed in the [ClockWidget]
class ClockTime {
  ClockTime({
    required this.hour,
    required this.minute,
    this.second,
  }) : assert(
          hour >= 0 && minute >= 0 && hour <= 24 && minute <= 60,
        );

  final int hour;
  final int minute;
  final int? second;

  ClockTime copyWith({
    int? hour,
    int? minute,
    int? second,
  }) =>
      ClockTime(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
      );

  TimeOfDay get toTimeOfDay => TimeOfDay(
        hour: hour,
        minute: minute,
      );
}

extension TimeOfDayToClock on TimeOfDay {
  ClockTime get toClockTime => ClockTime(
        hour: hour,
        minute: minute,
      );

  String get toStringTime =>
      '${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
}
