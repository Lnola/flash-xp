import { Entity, Index, ManyToOne, Property, Unique } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { PracticeQuestion } from '.';

@Entity({ tableName: 'box' })
@Unique({ properties: ['question', 'learnerId', 'index'] })
@Index({ properties: ['deckId', 'learnerId', 'availableFrom'] })
export class Box extends BaseEntity {
  @Property()
  deckId!: number;

  @Property()
  learnerId!: number;

  @Property()
  index!: number;

  @Property()
  availableFrom: Date = startOfDay(new Date());

  @ManyToOne(() => PracticeQuestion)
  question!: PracticeQuestion;

  constructor({ deckId, learnerId, question }: BoxConstructorProps) {
    super();
    this.deckId = deckId;
    this.learnerId = learnerId;
    this.index = 1;
    this.question = question;
  }
}

type BoxConstructorProps = {
  deckId: number;
  learnerId: number;
  question: PracticeQuestion;
};
