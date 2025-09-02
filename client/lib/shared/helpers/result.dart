class Result<T> {
  final bool success;
  final T? data;
  final String? error;

  Result._({required this.success, this.data, this.error});

  factory Result.success([T? data]) {
    return Result._(success: true, data: data);
  }

  factory Result.failure(String error, [T? data]) {
    return Result._(success: false, data: data, error: error);
  }
}
