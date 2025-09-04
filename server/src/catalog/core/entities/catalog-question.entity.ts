import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { CatalogBox } from 'catalog/integration';
import BaseEntity from 'shared/database/base.entity';
import { CatalogDeck, CatalogQuestionType } from '.';

@Entity({ tableName: 'question' })
export class CatalogQuestion extends BaseEntity {
  @Property()
  text!: string;

  @Property({ nullable: true })
  answer?: string;

  @Property({ persist: false })
  boxIndex?: number;

  @ManyToOne(() => CatalogDeck, { nullable: true })
  deck?: CatalogDeck;

  @ManyToOne(() => CatalogQuestionType, { eager: true })
  questionType!: CatalogQuestionType;

  setBoxIndex(boxIndex: CatalogBox['index'] = 1) {
    this.boxIndex = boxIndex;
  }
}
