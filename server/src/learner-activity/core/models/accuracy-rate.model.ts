export class AccuracyRate {
  correct!: number;
  total!: number;
  value!: number;

  constructor({ correct, total }: ConstructorProps) {
    this.correct = Number(correct);
    this.total = Number(total);
    this.value = this.total > 0 ? this.correct / this.total : 0;
  }
}

type ConstructorProps = {
  correct: number;
  total: number;
};
