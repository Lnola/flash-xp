import { defineConfig } from '@mikro-orm/core';
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
  entities: [`./**/entities/*.entity.ts`],
});
