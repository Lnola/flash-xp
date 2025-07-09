import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { AnswerOption } from 'catalog/core/entities';
import { DatabaseSeederContext } from '.';

const answerOptions = [
  { text: 'Paris', isCorrect: true, questionIndex: 0 },
  { text: 'Berlin', isCorrect: false, questionIndex: 0 },
  { text: 'Madrid', isCorrect: false, questionIndex: 0 },
  { text: 'London', isCorrect: false, questionIndex: 0 },
  { text: 'Paris', isCorrect: false, questionIndex: 1 },
  { text: 'Berlin', isCorrect: true, questionIndex: 1 },
  { text: 'Madrid', isCorrect: false, questionIndex: 1 },
  { text: 'London', isCorrect: false, questionIndex: 1 },
  { text: 'Paris', isCorrect: false, questionIndex: 2 },
  { text: 'Berlin', isCorrect: false, questionIndex: 2 },
  { text: 'Madrid', isCorrect: true, questionIndex: 2 },
  { text: 'London', isCorrect: false, questionIndex: 2 },
  { text: 'Paris', isCorrect: false, questionIndex: 3 },
  { text: 'Berlin', isCorrect: false, questionIndex: 3 },
  { text: 'Madrid', isCorrect: false, questionIndex: 3 },
  { text: 'London', isCorrect: true, questionIndex: 3 },
  { text: 'Einstein', isCorrect: true, questionIndex: 8 },
  { text: 'Newton', isCorrect: false, questionIndex: 8 },
  { text: 'Galileo', isCorrect: false, questionIndex: 8 },
  { text: 'Curie', isCorrect: false, questionIndex: 8 },
  { text: 'Einstein', isCorrect: true, questionIndex: 9 },
  { text: 'Newton', isCorrect: false, questionIndex: 9 },
  { text: 'Galileo', isCorrect: false, questionIndex: 9 },
  { text: 'Curie', isCorrect: false, questionIndex: 9 },
  { text: 'Einstein', isCorrect: true, questionIndex: 10 },
  { text: 'Newton', isCorrect: false, questionIndex: 10 },
  { text: 'Galileo', isCorrect: false, questionIndex: 10 },
  { text: 'Curie', isCorrect: false, questionIndex: 10 },
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
