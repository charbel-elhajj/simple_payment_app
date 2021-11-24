import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final Duration duration;
  final TextStyle style;

  const Countdown({
    Key? key,
    required this.duration,
    required this.style,
  }) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer? _timer;
  Duration _remainingTime = Duration(minutes: 10);

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedRemainingTime,
      key: UniqueKey(),
      style: widget.style,
    );
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (_remainingTime == Duration.zero) {
          setState(() {
            timer.cancel();
          });

          return Navigator.pop(context);
        }

        setState(() {
          _remainingTime -= Duration(seconds: 1);
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedRemainingTime {
    return "${_remainingTime.inMinutes}:${_remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
