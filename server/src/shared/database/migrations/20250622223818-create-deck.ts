import { Migration } from '@mikro-orm/migrations';

export class CreateDeck extends Migration {
  override up(): void {
    this.addSql(
      `create table "deck" ("id" serial primary key, "title" varchar(255) not null, "description" varchar(255) not null);`,
    );
  }

  override down(): void {
    this.addSql(`drop table if exists "deck" cascade;`);
  }
}
