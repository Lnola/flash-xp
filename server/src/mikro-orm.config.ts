import * as dotenv from 'dotenv';
import databaseConfigFactory from './config/database.config';
import mikroOrmConfig from './config/orm.config';
import { defineConfig } from '@mikro-orm/core';

dotenv.config();

export default defineConfig({
  ...databaseConfigFactory(),
  ...mikroOrmConfig,
  entities: [`./**/entities/*.entity.ts`],
});
