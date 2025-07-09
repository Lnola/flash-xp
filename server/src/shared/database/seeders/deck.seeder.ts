import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Deck } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

export class DeckSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedDecks = decks.map((it, index) => {
      const { users } = context;
      const author = users[(index % (users.length - 1)) + 1];
      return new Deck({
        ...it,
        authorId: author.id,
      });
    });
    context.decks = seedDecks;
    return em.persistAndFlush(seedDecks);
  }
}

const decks = [
  {
    title: 'Basic Spanish Phrases',
    description:
      'Learn essential phrases for travel and everyday conversations in Spanish.',
  },
  {
    title: 'World War II Overview',
    description: 'Key events, dates, and figures from the Second World War.',
  },
  {
    title: 'Introduction to JavaScript',
    description: 'Core concepts and syntax of JavaScript programming.',
  },
  {
    title: 'Human Anatomy - Skeletal System',
    description: 'Bones of the human body and their functions.',
  },
  {
    title: 'European Capitals',
    description: 'Match European countries with their capitals.',
  },
  {
    title: 'Photosynthesis Process',
    description: 'Steps and components involved in photosynthesis.',
  },
  {
    title: 'US Presidents',
    description:
      'Learn the names and terms of the Presidents of the United States.',
  },
  {
    title: 'Mathematics - Algebra Basics',
    description: 'Foundational algebra concepts and operations.',
  },
  {
    title: 'Shakespearean Plays',
    description: 'Famous plays by William Shakespeare and their summaries.',
  },
  {
    title: 'Cybersecurity Fundamentals',
    description:
      'Common threats and basic practices for staying secure online.',
  },
];
