import {
  Cascade,
  Collection,
  Entity,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { Question } from '.';

type CreateDeckProps = {
  authorId: number;
  title: string;
  description: string;
};

@Entity({ tableName: 'deck' })
export class Deck extends BaseEntity {
  @Property({ length: 50 })
  title!: string;

  @Property({ length: 300 })
  description!: string;

  @Property()
  authorId!: Author['id'];

  @OneToMany(() => Question, (question) => question.deck, {
    cascade: [Cascade.REMOVE, Cascade.PERSIST],
  })
  questions = new Collection<Question>(this);

  constructor({ authorId, title, description }: CreateDeckProps) {
    super();
    this.authorId = authorId;
    this.title = title;
    this.description = description;
  }

  setQuestions(questions: Question[]) {
    this.questions.set(questions);
  }

  clone(): Deck {
    const clonedDeck = new Deck(this);
    const clonedQuestions = this.questions.map((question) =>
      question.clone(clonedDeck),
    );
    clonedDeck.setQuestions(clonedQuestions);
    return clonedDeck;
  }
}
