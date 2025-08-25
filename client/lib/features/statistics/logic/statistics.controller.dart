import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flutter/material.dart';

class StatController<T> {
  bool isLoading = true;
  String? error;
  T? data;

  StatController.loading()
      : isLoading = true,
        error = null,
        data = null;
  StatController.error(this.error)
      : isLoading = false,
        data = null;
  StatController.data(this.data)
      : isLoading = false,
        error = null;
}

// To improve performance it would be great to break this
// controller into multiple per widget controllers
// each controlling their own loading, error and data
class StatisticsController extends ChangeNotifier {
  final StatisticsRepository _statisticsRepository;

  StatController<int> dailyStreakController = StatController.loading();

  StatisticsController(this._statisticsRepository) {
    _init();
  }

  Future<void> _init() async {
    dailyStreakController = StatController.loading();
    notifyListeners();

    final result = await _statisticsRepository.getDailyStreak();
    if (result.error != null || result.data == null) {
      dailyStreakController = StatController.error(result.error);
      notifyListeners();
      return;
    }

    dailyStreakController = StatController.data(result.data!);
    notifyListeners();
  }
}
