import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeViewModel extends StateNotifier<DateTime> {
  Timer? _timer;

  TimeViewModel() : super(DateTime.now()) {
    _updateTime();
    _startTimer();
  }

  void _updateTime() {
    state = DateTime.now();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _updateTime();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimeViewModel, DateTime>(
  (ref) => TimeViewModel(),
);
