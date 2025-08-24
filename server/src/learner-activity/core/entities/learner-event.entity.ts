import { Entity } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'learner_event' })
export class LearnerEvent extends BaseEntity {}
