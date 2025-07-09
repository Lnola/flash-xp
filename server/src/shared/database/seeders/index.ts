import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Learner } from 'catalog/core/entities/learner.entity';
import { DeckSeeder } from './deck.seeder';
import { UserSeeder } from './user.seeder';

const seeders = [UserSeeder, DeckSeeder];

export class DatabaseSeeder extends Seeder {
  async run(em: EntityManager): Promise<void> {
    return this.call(em, seeders);
  }
}

export type DatabaseSeederContext = {
  users: Learner[];
};
