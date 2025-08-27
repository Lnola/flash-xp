export class IncorrectlyAnsweredQuestion {
  id!: number;
  text!: string;
  deckId!: number;
  deckTitle!: string;
  count!: number;

  constructor({ count, id, text, deckId, deckTitle }: ConstructorProps) {
    this.id = Number(id);
    this.text = String(text);
    this.deckId = Number(deckId);
    this.deckTitle = String(deckTitle);
    this.count = Number(count);
  }
}

type ConstructorProps = {
  id: number;
  text: string;
  deckId: number;
  deckTitle: string;
  count: number;
};
