import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';
import { CatalogDeck } from './catalog-deck.entity';

@Entity({ tableName: 'question' })
export class CatalogQuestion extends BaseEntity {
  @Property()
  text!: string;

  @Property({ nullable: true })
  answer?: string;

  @ManyToOne(() => CatalogDeck, { nullable: true })
  deck?: CatalogDeck;
}
