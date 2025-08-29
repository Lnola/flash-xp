import {
  Collection,
  Entity,
  Formula,
  OneToMany,
  Property,
} from '@mikro-orm/core';
import { CatalogBox } from 'catalog/integration';
import BaseEntity from 'shared/database/base.entity';
import { Bookmark, CatalogQuestion } from '.';

@Entity({ tableName: 'deck' })
export class CatalogDeck extends BaseEntity {
  @Property()
  title!: string;

  @Property()
  description!: string;

  @Property()
  authorId!: number;

  @Property({ persist: false })
  progress?: number;

  @OneToMany(() => Bookmark, (bookmark) => bookmark.deck)
  bookmarks? = new Collection<Bookmark>(this);

  @OneToMany(() => CatalogQuestion, (question) => question.deck)
  questions? = new Collection<CatalogQuestion>(this);

  // Formulas are used to calculate the values without populating the questions and question types -> better performance
  // This value is calculated on every fetch. This behavior can be stopped
  // by setting { lazy: true } here. However, that will require all uses to
  // explicitly set { populate : ['questionCount'] }.
  @Formula(
    (alias) =>
      `(SELECT CAST(COUNT(*) as INT) 
        FROM question q 
        WHERE q.deck_id = ${alias}.id)`,
  )
  questionCount!: number;

  @Formula(
    (alias) =>
      `(SELECT qt.name 
      FROM question q 
      JOIN question_type qt ON q.question_type_id = qt.id 
      WHERE q.deck_id = ${alias}.id 
      LIMIT 1)`,
  )
  questionType!: string;

  isBookmarkedByLearner(learnerId: number): boolean {
    if (!this.bookmarks) return false;
    return this.bookmarks?.getItems().some((it) => it.learnerId === learnerId);
  }

  setProgress(progress: number) {
    this.progress = progress;
  }

  assignBoxes(boxes: CatalogBox[]) {
    this.questions?.getItems().forEach((question) => {
      const box = boxes.find(({ questionId }) => questionId === question.id);
      if (box) question.setBoxIndex(box.index);
    });
  }
}
