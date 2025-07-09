import { Knex } from '@mikro-orm/postgresql';

export const createBaseEntity = (
  table: Knex.CreateTableBuilder,
  knex: Knex,
) => {
  table.increments('id');
  table
    .timestamp('created_at', { useTz: true })
    .notNullable()
    .defaultTo(knex.fn.now());
  table
    .timestamp('updated_at', { useTz: true })
    .notNullable()
    .defaultTo(knex.fn.now());
};
