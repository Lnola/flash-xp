export class Result<T> {
  success: boolean;
  data?: T;
  error?: string;

  private constructor(success: boolean, data?: T, error?: string) {
    this.success = success;
    this.data = data;
    this.error = error;
  }

  static success<T>(data?: T) {
    return new Result(true, data);
  }

  static failure<T>(error: string, data?: T) {
    return new Result(false, data, error);
  }
}
