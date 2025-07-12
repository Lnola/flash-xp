import { Module } from '@nestjs/common';
import { CatalogModule } from 'catalog/catalog.module';
import { DbConfigModule } from 'config/database.config';
import { OrmConfigModule } from 'config/orm.config';
import { FirebaseAuthGuardProvider } from 'shared/guards';
import { FirebaseProvider } from 'shared/providers';

@Module({
  imports: [DbConfigModule, OrmConfigModule, CatalogModule],
  providers: [FirebaseProvider, FirebaseAuthGuardProvider],
})
export class AppModule {}
