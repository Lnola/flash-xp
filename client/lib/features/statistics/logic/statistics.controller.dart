import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flashxp/features/statistics/logic/models/accuracy_rate.model.dart';
import 'package:flashxp/features/statistics/logic/models/daily_correct_incorrect.model.dart';
import 'package:flashxp/shared/helpers/result.dart';
import 'package:flutter/material.dart';

class StatStore<T> {
  bool isLoading = true;
  String? error;
  T? data;

  void setLoading() {
    this.isLoading = true;
    this.error = null;
    this.data = null;
  }

  void setError(String error) {
    this.isLoading = false;
    this.error = error;
    this.data = null;
  }

  void setData(T data) {
    this.isLoading = false;
    this.error = null;
    this.data = data;
  }

  Future<void> load(Future<Result<T>> Function() fetch) async {
    setLoading();
    try {
      final result = await fetch();
      if (result.error != null || result.data == null) {
        return setError(result.error ?? 'Unknown error');
      }
      setData(result.data as T);
    } catch (e) {
      setError(e.toString());
    }
  }
}

// To improve performance it would be great to break this
// controller into multiple per widget controllers
// each controlling their own loading, error and data
class StatisticsController extends ChangeNotifier {
  final StatisticsRepository _statisticsRepository;

  final dailyStreak = StatStore<int>();
  final answerCountToday = StatStore<int>();
  final answerCountTotal = StatStore<int>();
  final deckCountToday = StatStore<int>();
  final deckCountTotal = StatStore<int>();
  final dailyCorrectIncorrect = StatStore<List<DailyCorrectIncorrect>>();
  final accuracyRate = StatStore<AccuracyRate>();

  StatisticsController(this._statisticsRepository) {
    // Future.delayed(const Duration(milliseconds: 1000), () {
    _initDailyStreak();
    _initAnswerCount();
    _initDeckCount();
    _initDailyCorrectIncorrect();
    _initAccuracyRate();
    // });
  }

  Future<void> _initDailyStreak() async {
    await dailyStreak.load(_statisticsRepository.getDailyStreak);
    notifyListeners();
  }

  Future<void> _initAnswerCount() async {
    final todayQueryParams = {'interval': '1'};
    await answerCountToday.load(
      () => _statisticsRepository.getAnswerCount(queryParams: todayQueryParams),
    );
    await answerCountTotal.load(
      () => _statisticsRepository.getAnswerCount(),
    );
    notifyListeners();
  }

  Future<void> _initDeckCount() async {
    final todayQueryParams = {'interval': '1'};
    await deckCountToday.load(
      () => _statisticsRepository.getDeckCount(queryParams: todayQueryParams),
    );
    await deckCountTotal.load(
      () => _statisticsRepository.getDeckCount(),
    );
    notifyListeners();
  }

  Future<void> _initDailyCorrectIncorrect() async {
    await dailyCorrectIncorrect.load(
      _statisticsRepository.getDailyCorrectIncorrect,
    );
    notifyListeners();
  }

  Future<void> _initAccuracyRate() async {
    await accuracyRate.load(_statisticsRepository.getAccuracyRate);
    notifyListeners();
  }
}
