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

  @OneToMany(() => CatalogBox, (box) => box.question)
  boxes? = new Collection<CatalogBox>(this);
}
