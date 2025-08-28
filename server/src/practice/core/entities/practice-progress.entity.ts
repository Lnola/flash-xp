import { Entity, Property } from '@mikro-orm/core';

@Entity({ expression: 'select * from practice_progress_view' })
export class PracticeProgress {
  @Property()
  learnerId!: number;

  @Property()
  deckId!: number;

  @Property({ type: 'decimal' })
  progress!: number;
}
