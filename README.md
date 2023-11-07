
Create custom analog clocks in an easy way.

## Features

- Change the time by moving the clock hands and customize the movement
- Show hour labels in the clock
- Change clock hands thickness and shape
- Change background, clock hands, labels and circle colors
- Convert to TimeOfDay, to ClockTime, or to StringTime using getters


## Getting started

Import the package

```dart
import 'package:clocks/clocks.dart';
```


## Usage

Use ClockWidget to create the analog clock and then you can modify its parameters.

To get the timeofday from the clock use the onDrag parameter, so the parameter will listen to the updated clock TimeOfDay. 

```dart
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
```


## Additional information

For more information or for any issue please contact gerard.ggf@gmail.com
