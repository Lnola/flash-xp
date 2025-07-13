import { Migration } from '@mikro-orm/migrations';

const USER_TABLE_NAME = 'user';

export class AddUserAttributes extends Migration {
  override up(): void {
    const knex = this.getKnex();

    const addUserAttributes = knex.schema.alterTable(
      USER_TABLE_NAME,
      (table) => {
        table.string('sso_id').notNullable();
      },
    );

    this.addSql(addUserAttributes.toQuery());
  }

  override down(): void {
    const knex = this.getKnex();
    const dropUser = knex.schema.dropTable(USER_TABLE_NAME);
    this.addSql(dropUser.toQuery());
  }
}
