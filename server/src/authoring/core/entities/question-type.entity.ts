import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'question_type' })
export class QuestionType extends BaseEntity {
  @Property()
  name!: string;

  constructor({ name }: QuestionTypeConstructorProps) {
    super();
    this.name = name;
  }
}

type QuestionTypeConstructorProps = {
  name: string;
};
