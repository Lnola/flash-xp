import { defineConfig } from '@mikro-orm/core';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseConfig } from 'config/database.config';

const mikroOrmConfig = {
  driver: PostgreSqlDriver,
  discovery: { checkDuplicateTableNames: false },
  debug: true,
  autoLoadEntities: true,
};
export default mikroOrmConfig;

export const OrmConfigModule = MikroOrmModule.forRootAsync({
  imports: [ConfigModule],
  inject: [ConfigService],
  driver: mikroOrmConfig.driver,
  useFactory: (config: ConfigService) =>
    defineConfig({
      ...config.get<DatabaseConfig>('database'),
      ...mikroOrmConfig,
    }),
});
