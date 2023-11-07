import 'package:clocks/data_models/clock_time.dart';
import 'package:flutter/material.dart';

extension TimeOfDayToClockTime on TimeOfDay {
  ClockTime get toClockTime => ClockTime(
        hour: hour,
        minute: minute,
      );
}
