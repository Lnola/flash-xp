import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { QuestionType } from 'catalog/core/entities';
import { DatabaseSeederContext } from '.';

const questionTypes = [
  { name: 'Multiple Choice' },
  { name: 'Self Assessment' },
];

export class QuestionTypeSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedQuestionTypes = questionTypes.map((it) => {
      return new QuestionType(it);
    });
    context.questionTypes = seedQuestionTypes;
    return em.persistAndFlush(seedQuestionTypes);
  }
}
