import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { AnswerOption } from 'catalog/core/entities';
import { DatabaseSeederContext } from '.';

const answerOptions = [
  {
    text: 'Paris',
    isCorrect: false,
    questionIndex: 0,
  },
  {
    text: 'Berlin',
    isCorrect: false,
    questionIndex: 0,
  },
  {
    text: 'Madrid',
    isCorrect: false,
    questionIndex: 0,
  },
  {
    text: 'London',
    isCorrect: false,
    questionIndex: 0,
  },
  {
    text: 'Einstein',
    isCorrect: false,
    questionIndex: 1,
  },
  {
    text: 'Newton',
    isCorrect: false,
    questionIndex: 1,
  },
  {
    text: 'Galileo',
    isCorrect: false,
    questionIndex: 1,
  },
  {
    text: 'Curie',
    isCorrect: false,
    questionIndex: 1,
  },
];

export class AnswerOptionSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedAnswerOptions = answerOptions.map((it) => {
      return new AnswerOption({
        ...it,
        question: context.questions[it.questionIndex],
      });
    });
    return em.persistAndFlush(seedAnswerOptions);
  }
}
