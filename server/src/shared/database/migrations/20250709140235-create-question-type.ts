import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const QUESTION_TYPE_TABLE_NAME = 'question_type';

export class CreateQuestionType extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createQuestionType = knex.schema.createTable(
      QUESTION_TYPE_TABLE_NAME,
      (table) => {
        createBaseEntity(table, knex);
        table.string('name').notNullable();
      },
    );

    this.addSql(createQuestionType.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropQuestionType = knex.schema.dropTable(QUESTION_TYPE_TABLE_NAME);
    this.addSql(dropQuestionType.toQuery());
  }
}
