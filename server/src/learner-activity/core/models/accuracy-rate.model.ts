export class AccuracyRate {
  correct!: number;
  total!: number;
  value!: number;

  constructor({ correct, total }: AccuracyRateConstructorProps) {
    this.correct = Number(correct);
    this.total = Number(total);
    this.value = this.total > 0 ? this.correct / this.total : 0;
  }
}

type AccuracyRateConstructorProps = {
  correct: number;
  total: number;
};
