import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Deck } from 'catalog/core/entities';
import { DatabaseSeederContext } from '.';

const decks = [
  { title: 'Title1', description: 'Description1' },
  { title: 'Title2', description: 'Description2' },
  { title: 'Title3', description: 'Description3' },
  { title: 'Title4', description: 'Description4' },
  { title: 'Title5', description: 'Description5' },
  { title: 'Title6', description: 'Description6' },
  { title: 'Title7', description: 'Description7' },
  { title: 'Title8', description: 'Description8' },
  { title: 'Title9', description: 'Description9' },
  { title: 'Title10', description: 'Description10' },
];

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
    return em.persistAndFlush(seedDecks);
  }
}
