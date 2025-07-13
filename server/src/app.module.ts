import { Module } from '@nestjs/common';
import { CatalogModule } from 'catalog/catalog.module';
import { AuthModule } from 'shared/auth/auth.module';
import { DbConfigModule, OrmConfigModule } from 'shared/config';
import { FirebaseProvider } from 'shared/providers';

@Module({
  imports: [DbConfigModule, OrmConfigModule, AuthModule, CatalogModule],
  providers: [FirebaseProvider],
})
export class AppModule {}
