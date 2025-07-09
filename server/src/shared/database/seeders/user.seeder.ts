import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Learner } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

const users = [{}, {}, {}];

export class UserSeeder extends Seeder {
  run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedUsers = users.map(() => {
      // TODO: update Learner to User once that is implemented
      return new Learner();
    });
    context.users = seedUsers;
    return em.persistAndFlush(seedUsers);
  }
}
