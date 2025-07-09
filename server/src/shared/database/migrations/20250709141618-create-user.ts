import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const USER_TABLE_NAME = 'user';
const DECK_TABLE_NAME = 'deck';

export class CreateUser extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createUser = knex.schema.createTable(USER_TABLE_NAME, (table) => {
      createBaseEntity(table, knex);
    });

    const addUserToDeck = knex.schema.alterTable(DECK_TABLE_NAME, (table) => {
      table.integer('user_id').notNullable();
      table.foreign('user_id').references('user.id');
    });

    this.addSql(createUser.toQuery());
    this.addSql(addUserToDeck.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropUser = knex.schema.dropTable(USER_TABLE_NAME);
    this.addSql(dropUser.toQuery());
  }
}
