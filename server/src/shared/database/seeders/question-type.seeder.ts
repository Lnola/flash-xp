import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { QuestionType } from 'catalog/core/entities';

const questionTypes = [
  { name: 'Multiple Choice' },
  { name: 'Self Assessment' },
];

export class QuestionTypeSeeder extends Seeder {
  async run(em: EntityManager): Promise<void> {
    const seedQuestionTypes = questionTypes.map((it) => {
      return new QuestionType(it);
    });
    return em.persistAndFlush(seedQuestionTypes);
  }
}
