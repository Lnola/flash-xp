import { MikroOrmModule } from '@mikro-orm/nestjs';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseConfig } from './database.config';

export const OrmConfigModule = MikroOrmModule.forRootAsync({
  imports: [ConfigModule],
  inject: [ConfigService],
  useFactory: (config: ConfigService) => ({
    ...config.get<DatabaseConfig>('database'),
    driver: PostgreSqlDriver,
    debug: true,
    autoLoadEntities: true,
    discovery: { checkDuplicateTableNames: false },
  }),
});
