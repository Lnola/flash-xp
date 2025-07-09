import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Deck, Learner, Question, QuestionType } from 'catalog/core/entities';
import { AnswerOptionSeeder } from './answer-option.seeder';
import { DeckSeeder } from './deck.seeder';
import { QuestionTypeSeeder } from './question-type.seeder';
import { QuestionSeeder } from './question.seeder';
import { UserSeeder } from './user.seeder';

const seeders = [
  UserSeeder,
  DeckSeeder,
  QuestionTypeSeeder,
  QuestionSeeder,
  AnswerOptionSeeder,
];

export class DatabaseSeeder extends Seeder {
  async run(em: EntityManager): Promise<void> {
    return this.call(em, seeders);
  }
}

export type DatabaseSeederContext = {
  users: Learner[];
  decks: Deck[];
  questionTypes: QuestionType[];
  questions: Question[];
};
