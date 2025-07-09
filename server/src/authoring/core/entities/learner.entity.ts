import { Entity } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'user' })
export class Learner extends BaseEntity {}
