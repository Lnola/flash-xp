import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const DECK_TABLE_NAME = 'deck';

export class CreateDeck extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createDeck = knex.schema.createTable(DECK_TABLE_NAME, (table) => {
      createBaseEntity(table, knex);
      table.string('title', 50).notNullable();
      table.string('description', 300).notNullable();
    });

    this.addSql(createDeck.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropDeck = knex.schema.dropTable(DECK_TABLE_NAME);
    this.addSql(dropDeck.toQuery());
  }
}
