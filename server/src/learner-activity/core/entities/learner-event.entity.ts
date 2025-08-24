import { Entity, Property } from '@mikro-orm/core';
import { LearnerEventType } from 'shared/constants';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'learner_event' })
export class LearnerEvent extends BaseEntity {
  @Property()
  learnerId!: number;

  @Property()
  type!: LearnerEventType;

  @Property({ type: 'jsonb', nullable: true })
  payload?: LearnerEventPayload;
}

type LearnerEventPayload = Record<string, boolean | number>;
