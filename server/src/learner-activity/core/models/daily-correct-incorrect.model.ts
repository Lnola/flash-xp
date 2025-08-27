export class DailyCorrectIncorrect {
  day!: string;
  correct!: number;
  incorrect!: number;

  constructor({ day, correct, incorrect }: ConstructorProps) {
    this.day = String(day);
    this.correct = Number(correct);
    this.incorrect = Number(incorrect);
  }
}

type ConstructorProps = {
  day: string;
  correct: number;
  incorrect: number;
};
