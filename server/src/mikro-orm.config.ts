import * as dotenv from 'dotenv';
import databaseConfigFactory from './config/database.config';
import mikroOrmConfig from './config/orm.config';
import { defineConfig } from '@mikro-orm/core';

dotenv.config();

export default defineConfig({
  ...databaseConfigFactory(),
  ...mikroOrmConfig,
  migrations: {
    path: `${process.cwd()}/src/shared/database/migrations`,
    disableForeignKeys: false,
    fileName: (timestamp: string) => `${timestamp}-new-migration`,
  },
  entities: [`./**/entities/*.entity.ts`],
});
