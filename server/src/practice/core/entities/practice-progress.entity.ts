import { Entity, Property } from '@mikro-orm/core';

@Entity({ expression: 'select * from learner_deck_progress_view' })
export class PracticeProgress {
  @Property()
  learnerId!: number;

  @Property()
  deckId!: number;

  @Property({ type: 'decimal' })
  progress!: number;
}
