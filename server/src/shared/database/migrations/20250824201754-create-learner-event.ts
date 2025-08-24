import { Migration } from '@mikro-orm/migrations';
import { createBaseEntity } from './queries/create-base-entity';

const LEARNER_EVENT_TABLE_NAME = 'learner_event';
const LEARNER_EVENT_TYPES = ['ANSWER_SUBMITTED'];

export class CreateLearnerEvent extends Migration {
  override up(): void {
    const knex = this.getKnex();
    const createLearnerEvent = knex.schema.createTable(
      LEARNER_EVENT_TABLE_NAME,
      (table) => {
        createBaseEntity(table, knex);
        table.integer('learner_id').notNullable();
        table.foreign('learner_id').references('user.id');
        table.enum('type', LEARNER_EVENT_TYPES).notNullable();
        table.jsonb('payload').nullable();
      },
    );

    this.addSql(createLearnerEvent.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropLearnerEvent = knex.schema.dropTable(LEARNER_EVENT_TABLE_NAME);
    this.addSql(dropLearnerEvent.toQuery());
  }
}
