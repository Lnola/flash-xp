import { Entity, Filter, ManyToOne, Property } from '@mikro-orm/core';
import { startOfDay } from 'date-fns';
import BaseEntity from 'shared/database/base.entity';
import { CatalogQuestion } from '.';

@Entity({ tableName: 'box' })
@Filter({
  name: 'boxByLearner',
  cond: (args: { learnerId: number }) => ({ learnerId: args.learnerId }),
})
export class CatalogBox extends BaseEntity {
  @Property()
  deckId!: number;

  @Property()
  learnerId!: number;

  @Property()
  index!: number;

  @Property()
  availableFrom: Date = startOfDay(new Date());

  @ManyToOne(() => CatalogQuestion)
  question!: CatalogQuestion;
}
