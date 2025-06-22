import { Module } from '@nestjs/common';
import { DbConfigModule } from 'config/database.config';
import { OrmConfigModule } from 'config/orm.config';

@Module({
  imports: [DbConfigModule, OrmConfigModule],
})
export class AppModule {}
