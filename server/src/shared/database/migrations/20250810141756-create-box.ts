import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const BOX_TABLE_NAME = 'box';

export class CreateBox extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createBox = knex.schema.createTable(BOX_TABLE_NAME, (table) => {
      createBaseEntity(table, knex);
      table.integer('learner_id').notNullable();
      table.foreign('learner_id').references('user.id');
      table.integer('question_id').notNullable();
      table.foreign('question_id').references('question.id');
      table.integer('deck_id').notNullable();
      table.integer('index').notNullable();
      table.timestamp('available_from').notNullable();
      table.unique(['question_id', 'learner_id', 'index']);
      table.index(['deck_id', 'learner_id', 'available_from']);
    });

    this.addSql(createBox.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropBox = knex.schema.dropTable(BOX_TABLE_NAME);
    this.addSql(dropBox.toQuery());
  }
}
