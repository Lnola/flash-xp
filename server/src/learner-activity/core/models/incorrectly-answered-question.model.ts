export class IncorrectlyAnsweredQuestion {
  id!: number;
  text!: string;
  deckTitle!: string;
  count!: number;

  constructor({ count, id, text, deckTitle }: ConstructorProps) {
    this.id = Number(id);
    this.text = String(text);
    this.deckTitle = String(deckTitle);
    this.count = Number(count);
  }
}

type ConstructorProps = {
  id: number;
  text: string;
  deckTitle: string;
  count: number;
};
