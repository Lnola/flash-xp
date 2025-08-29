import { Entity, Index, ManyToOne, Property, Unique } from '@mikro-orm/core';
import { addDays, startOfDay } from 'date-fns';
import { BOX_MAX_INDEX } from 'shared/constants';
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

  @Property({ persist: false })
  get questionId(): number | undefined {
    return this.question.id;
  }

  constructor({ deckId, learnerId, question }: BoxConstructorProps) {
    super();
    this.deckId = deckId;
    this.learnerId = learnerId;
    this.index = 1;
    this.question = question;
  }

  incrementBox(): void {
    if (this.index >= BOX_MAX_INDEX) return;
    const today = startOfDay(new Date());
    this.availableFrom = addDays(today, this.index);
    this.index += 1;
  }
}

type BoxConstructorProps = {
  deckId: number;
  learnerId: number;
  question: PracticeQuestion;
};
