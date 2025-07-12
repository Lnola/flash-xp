import { defineConfig } from '@mikro-orm/core';
import { SeedManager } from '@mikro-orm/seeder';
import * as dotenv from 'dotenv';
import { databaseConfigFactory, mikroOrmDriver } from 'shared/config';

dotenv.config();

export default defineConfig({
  ...databaseConfigFactory(),
  driver: mikroOrmDriver,
  discovery: { checkDuplicateTableNames: false },
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
