import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const QUESTION_TABLE_NAME = 'question';

export class CreateQuestion extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createQuestion = knex.schema.createTable(
      QUESTION_TABLE_NAME,
      (table) => {
        createBaseEntity(table, knex);
        table.string('text').notNullable();
        table.string('answer').nullable();
        table.integer('deck_id').notNullable();
        table.foreign('deck_id').references('deck.id');
        table.integer('question_type_id').notNullable();
        table.foreign('question_type_id').references('question_type.id');
      },
    );

    this.addSql(createQuestion.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropQuestion = knex.schema.dropTable(QUESTION_TABLE_NAME);
    this.addSql(dropQuestion.toQuery());
  }
}
