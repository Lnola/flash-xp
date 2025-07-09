import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

const QUESTION_TYPE_TABLE_NAME = 'question_type';

@Entity({ tableName: QUESTION_TYPE_TABLE_NAME })
export class QuestionType extends BaseEntity {
  @Property()
  name!: string;
}
