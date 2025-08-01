import { ConfigModule, registerAs } from '@nestjs/config';

export type DatabaseConfig = {
  port: number;
  host?: string;
  dbName?: string;
  user?: string;
  password?: string;
};

export const databaseConfigFactory = registerAs<DatabaseConfig>(
  'database',
  () => ({
    port: parseInt(process.env.DB_PORT ?? '5432', 10),
    host: process.env.DB_HOST,
    dbName: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
  }),
) as () => DatabaseConfig;

export const DbConfigModule = ConfigModule.forRoot({
  load: [databaseConfigFactory],
});
