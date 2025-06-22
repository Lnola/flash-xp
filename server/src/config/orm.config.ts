import { defineConfig } from '@mikro-orm/core';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseConfig } from 'config/database.config';

export const mikroOrmDriver = PostgreSqlDriver;

export const OrmConfigModule = MikroOrmModule.forRootAsync({
  imports: [ConfigModule],
  inject: [ConfigService],
  driver: mikroOrmDriver,
  useFactory: (config: ConfigService) => ({
    ...config.get<DatabaseConfig>('database'),
    ...defineConfig({ driver: mikroOrmDriver }),
    discovery: { checkDuplicateTableNames: false },
    debug: true,
    autoLoadEntities: true,
  }),
});
