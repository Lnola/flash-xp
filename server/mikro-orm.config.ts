import { defineConfig } from '@mikro-orm/core';
import { SeedManager } from '@mikro-orm/seeder';
import * as dotenv from 'dotenv';
import databaseConfigFactory from 'config/database.config';
import { mikroOrmDriver } from 'config/orm.config';

dotenv.config();

export default defineConfig({
  ...databaseConfigFactory(),
  driver: mikroOrmDriver,
  migrations: {
    path: `${process.cwd()}/src/shared/database/migrations`,
    disableForeignKeys: false,
    fileName: (timestamp: string) => `${timestamp}-new-migration`,
  },
  seeder: {
    path: `${process.cwd()}/src/shared/database/seeders`,
    fileName: (className: string) =>
      `${className.toLowerCase().replace('seeder', '.seeder')}`,
  },
  entities: [`./**/entities/*.entity.ts`],
  extensions: [SeedManager],
});
