export class DailyCorrectIncorrect {
  day!: string;
  correct!: number;
  incorrect!: number;

  constructor({ day, correct, incorrect }: DailyCorrectConstructorProps) {
    this.day = String(day);
    this.correct = Number(correct);
    this.incorrect = Number(incorrect);
  }
}

type DailyCorrectConstructorProps = {
  day: string;
  correct: number;
  incorrect: number;
};
