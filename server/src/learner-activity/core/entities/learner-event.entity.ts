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

  constructor({ learnerId, type, payload }: LearnerEventConstructorProps) {
    super();
    this.learnerId = learnerId;
    this.type = type;
    if (payload) this.payload = payload;
  }
}

type LearnerEventPayload = Record<string, boolean | number>;

type LearnerEventConstructorProps = {
  learnerId: number;
  type: LearnerEventType;
  payload?: LearnerEventPayload;
};

export type CreateLearnerEventProps = LearnerEventConstructorProps;
