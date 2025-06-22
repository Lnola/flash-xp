import { MikroOrmModule } from '@mikro-orm/nestjs';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseConfig } from 'config/database.config';

const mikroOrmConfig = {
  driver: PostgreSqlDriver,
  discovery: { checkDuplicateTableNames: false },
  migrations: {
    path: `${process.cwd()}/src/shared/database/migrations`,
    disableForeignKeys: false,
  },
  debug: true,
};
export default mikroOrmConfig;

export const OrmConfigModule = MikroOrmModule.forRootAsync({
  imports: [ConfigModule],
  inject: [ConfigService],
  useFactory: (config: ConfigService) => ({
    ...config.get<DatabaseConfig>('database'),
    ...mikroOrmConfig,
    autoLoadEntities: true,
  }),
});
