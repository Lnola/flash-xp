import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Question } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

const questions = [
  {
    text: 'What is the capital of France?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Germany?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Spain?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of the UK?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'Explain the theory of relativity.',
    deckIndex: 1,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the theory of relativity.',
    deckIndex: 1,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the theory of relativity.',
    deckIndex: 1,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the theory of relativity.',
    deckIndex: 1,
    questionTypeIndex: 1,
  },
  {
    text: 'What is the largest mammal?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the largest mammal?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the largest mammal?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photosynthesis.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
];

export class QuestionSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedQuestions = questions.map((it) => {
      return new Question({
        ...it,
        deck: context.decks[it.deckIndex],
        questionType: context.questionTypes[it.questionTypeIndex],
      });
    });
    context.questions = seedQuestions;
    return em.persistAndFlush(seedQuestions);
  }
}
