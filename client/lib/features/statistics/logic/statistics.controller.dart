import 'package:flashxp/features/statistics/data/statistics.repository.dart';
import 'package:flutter/material.dart';

class StatisticsController extends ChangeNotifier {
  final StatisticsRepository _statisticsRepository;

  StatisticsController(this._statisticsRepository);
}
