import { Entity, Property, ManyToOne } from '@mikro-orm/core';
import { Deck } from 'catalog/core/entities/deck.entity';
import BaseEntity from 'shared/database/base.entity';
import { QuestionType } from './question-type.entity';

@Entity({ tableName: 'question' })
export class Question extends BaseEntity {
  @Property()
  text!: string;

  @ManyToOne(() => Deck, { hidden: true })
  deck!: Deck;

  @ManyToOne(() => QuestionType, { eager: true })
  questionType!: QuestionType;
}
