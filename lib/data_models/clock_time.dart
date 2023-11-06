import '../clocks.dart';

///Time to be displayed in the [ClockWidget]
class ClockTime {
  ClockTime({
    required this.hour,
    required this.minute,
    this.second,
  });

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
}
