import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const BOOKMARK_TABLE_NAME = 'bookmark';

export class CreateBookmark extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createBookmark = knex.schema.createTable(
      BOOKMARK_TABLE_NAME,
      (table) => {
        createBaseEntity(table, knex);
        table.integer('learner_id').notNullable();
        table.foreign('learner_id').references('user.id');
        table.integer('deck_id').notNullable();
        table.foreign('deck_id').references('deck.id');
      },
    );

    this.addSql(createBookmark.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropBookmark = knex.schema.dropTable(BOOKMARK_TABLE_NAME);
    this.addSql(dropBookmark.toQuery());
  }
}
