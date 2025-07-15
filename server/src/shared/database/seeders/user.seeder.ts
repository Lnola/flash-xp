import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { User } from 'shared/auth/entities';
import { DatabaseSeederContext } from '.';

export class UserSeeder extends Seeder {
  run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedUsers = users.map((it) => {
      return new User(it);
    });
    context.users = seedUsers;
    return em.persistAndFlush(seedUsers);
  }
}

const users = [
  { ssoId: 'FouvnrzjyIW6NP3AixejNinkUu02' },
  { ssoId: 'nBDBh8BBc3QTiFZrEdkPipUNe8e2' },
  { ssoId: 'uPNDSIdXplVwapNV4OAPGgLmLsj1' },
];
