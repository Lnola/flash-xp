import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { QuestionType } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

export class QuestionTypeSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedQuestionTypes = questionTypes.map((it) => {
      return new QuestionType(it);
    });
    context.questionTypes = seedQuestionTypes;
    return em.persistAndFlush(seedQuestionTypes);
  }
}

const questionTypes = [
  { name: 'Multiple Choice' },
  { name: 'Self Assessment' },
];
