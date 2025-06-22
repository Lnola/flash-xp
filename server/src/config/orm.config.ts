import { MikroOrmModule } from '@mikro-orm/nestjs';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseConfig } from './database.config';

export const OrmConfigModule = MikroOrmModule.forRootAsync({
  imports: [ConfigModule],
  inject: [ConfigService],
  useFactory: async (config: ConfigService) => {
    const databaseConfig: DatabaseConfig | undefined =
      await config.get('database');
    return {
      ...databaseConfig,
      driver: PostgreSqlDriver,
      debug: true,
      autoLoadEntities: true,
      discovery: { checkDuplicateTableNames: false },
    };
  },
});
