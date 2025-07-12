import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Author } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

const users = [{}, {}, {}];

export class UserSeeder extends Seeder {
  run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedUsers = users.map(() => {
      // TODO: update Author to User once that is implemented
      return new Author();
    });
    context.users = seedUsers;
    return em.persistAndFlush(seedUsers);
  }
}
