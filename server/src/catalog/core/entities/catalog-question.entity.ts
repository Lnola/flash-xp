import {
  Collection,
  Entity,
  ManyToOne,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogBox, CatalogDeck, CatalogQuestionType } from '.';

@Entity({ tableName: 'question' })
export class CatalogQuestion extends BaseEntity {
  @Property()
  text!: string;

  @Property({ nullable: true })
  answer?: string;

  @ManyToOne(() => CatalogDeck, { nullable: true })
  deck?: CatalogDeck;

  @ManyToOne(() => CatalogQuestionType, { eager: true })
  questionType!: CatalogQuestionType;

  @OneToMany(() => CatalogBox, (box) => box.question, { hidden: true })
  boxes? = new Collection<CatalogBox>(this);

  // This is meant to be used ONLY in conjunction with the boxByLearner filter.
  // It may be confusing to have this property on the question entity but it simplifies the logic in the service layer.
  // Possible future improvement: consider refactoring this logic to make it more explicit.
  @Property({ persist: false })
  get boxIndex(): number {
    if (!this.boxes?.getItems().length) return 1;
    return this.boxes?.getItems()[0].index;
  }
}
