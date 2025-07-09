import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

type CreateQuestionTypeProps = {
  name: string;
};
@Entity({ tableName: 'question_type' })
export class QuestionType extends BaseEntity {
  @Property()
  name!: string;

  constructor({ name }: CreateQuestionTypeProps) {
    super();
    this.name = name;
  }
}
