library clocks;

import 'dart:math' as math;

import 'package:clocks/data_models/clock_time.dart';
import 'package:flutter/material.dart';

///Widget that shows a custom analog clock
class ClockWidget extends StatefulWidget {
  const ClockWidget({
    super.key,
    required this.time,
    this.size = const Size(200, 200),
    this.showHoursLabel = false,
    this.needleWidth = 8,
    this.pointyNeedle = true,
    this.backgroundColor = Colors.transparent,
    this.color = Colors.black,
    this.onChanged,
  });

  ///Clock widget size.
  ///The default size is 200x200
  final Size size;

  ///Time that will be shown in the clock.
  ///If the seconds are not indicated, its hand will not be shown on the watch
  final ClockTime time;

  ///This parameter shows clock hours if true
  final bool showHoursLabel;

  ///Hour and minute needles are pointy if true and square if false
  ///The default value is true
  final bool pointyNeedle;

  ///Hour and minute needleWidth
  final double needleWidth;

  ///Inside clock background color
  ///It is transparent by default
  final Color backgroundColor;

  ///Outer circle, needles and labels color.
  ///It is black by default
  final Color color;

  ///Change the clock time moving its hands
  final void Function(ClockTime updatedTime)? onChanged;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late ClockTime timeMutable;

  @override
  void initState() {
    super.initState();
    timeMutable = widget.time;
  }

  double? initialAngle;
  double totalRotation = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: widget.onChanged == null
          ? null
          : (details) {
              if (timeMutable.minute >= 60) {
                if (timeMutable.hour >= 24) {
                  timeMutable = timeMutable.copyWith(hour: 0);
                }
                timeMutable =
                    timeMutable.copyWith(minute: 0, hour: timeMutable.hour + 1);
                return;
              }
              timeMutable =
                  timeMutable.copyWith(minute: timeMutable.minute + 1);
              setState(() {});
              widget.onChanged!(timeMutable);
            },
      child: CustomPaint(
        size: widget.size,
        painter: _ClockPainter(
          hour: timeMutable.hour.clamp(0, 24),
          minute: timeMutable.minute.clamp(0, 60),
          second: timeMutable.second?.clamp(0, 60),
          showHoursLabel: widget.showHoursLabel,
          needleWidth: widget.needleWidth,
          pointyNeedle: widget.pointyNeedle,
          backgroundColor: widget.backgroundColor,
          color: widget.color,
        ),
      ),
    );
  }
}

///CustomPainter for the clock
class _ClockPainter extends CustomPainter {
  _ClockPainter({
    required this.showHoursLabel,
    required this.hour,
    required this.minute,
    required this.second,
    required this.needleWidth,
    required this.pointyNeedle,
    required this.backgroundColor,
    required this.color,
  });

  final bool showHoursLabel;
  final bool pointyNeedle;

  final double needleWidth;

  final int hour;
  final int minute;
  final int? second;

  final Color backgroundColor;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    //Declare clock variables
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(center.dx, center.dy);

    final strokeCap = pointyNeedle ? StrokeCap.round : StrokeCap.butt;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final double hourAngle = (-90 + hour * 30 + minute * 0.5) * math.pi / 180;
    final double minuteAngle =
        (-90 + minute * 6 + (second ?? 0) * 0.1) * math.pi / 180;
    final double? secondAngle =
        second != null ? (-90 + second! * 6) * math.pi / 180 : null;

    //Draw the clock's circumference
    canvas.drawCircle(center, radius, paint);

    //Paints the clock inside
    canvas.drawCircle(
      center,
      radius,
      paint
        ..style = PaintingStyle.fill
        ..color = backgroundColor,
    );

    //Draw the hour needle
    canvas.drawLine(
      center,
      center +
          Offset(math.cos(hourAngle) * radius * 0.5,
              math.sin(hourAngle) * radius * 0.5),
      paint
        ..strokeWidth = needleWidth
        ..strokeCap = strokeCap
        ..color = color,
    );

    //Draw the minute needle
    canvas.drawLine(
      center,
      center +
          Offset(math.cos(minuteAngle) * radius * 0.7,
              math.sin(minuteAngle) * radius * 0.7),
      paint
        ..strokeWidth = needleWidth
        ..strokeCap = strokeCap
        ..color = color,
    );

    //Draw the second needle
    if (secondAngle != null) {
      canvas.drawLine(
        center,
        center +
            Offset(math.cos(secondAngle) * radius * 0.7,
                math.sin(secondAngle) * radius * 0.7),
        paint
          ..color = Colors.red
          ..strokeWidth = 3,
      );
    }

    //Paints the texts in the clock
    if (showHoursLabel) {
      for (int i = 1; i <= 12; i++) {
        final angle = (-90 + (i * 30)) * math.pi / 180;
        final x = center.dx + (radius - 15) * math.cos(angle);
        final y = center.dy + (radius - 15) * math.sin(angle);
        final textPainter = TextPainter(
          text: TextSpan(
            text: '$i',
            style: TextStyle(
              color: color,
              fontSize: radius / 9,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2),
        );
      }
    }

    //Draw the center circle
    canvas.drawCircle(
      center,
      4,
      paint
        ..color = color
        ..style = PaintingStyle.fill,
    );

    if (secondAngle != null) {
      //Draw the seconds center circle
      canvas.drawCircle(
        center,
        4,
        paint
          ..color = Colors.red
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
