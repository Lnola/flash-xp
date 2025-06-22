import { Module } from '@nestjs/common';
import { CatalogModule } from 'catalog/catalog.module';
import { DbConfigModule } from 'config/database.config';
import { OrmConfigModule } from 'config/orm.config';

@Module({
  imports: [DbConfigModule, OrmConfigModule, CatalogModule],
})
export class AppModule {}
