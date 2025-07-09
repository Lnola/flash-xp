import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const ANSWER_OPTION_TABLE_NAME = 'answer_option';

export class CreateAnswerOption extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createAnswerOption = knex.schema.createTable(
      ANSWER_OPTION_TABLE_NAME,
      (table) => {
        createBaseEntity(table, knex);
        table.string('text', 120).notNullable();
        table.boolean('is_correct');
        table.integer('question_id').notNullable();
        table.foreign('question_id').references('question.id');
      },
    );

    this.addSql(createAnswerOption.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropAnswerOption = knex.schema.dropTable(ANSWER_OPTION_TABLE_NAME);
    this.addSql(dropAnswerOption.toQuery());
  }
}
