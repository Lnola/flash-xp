import { Module } from '@nestjs/common';
import { AuthModule } from 'auth/auth.module';
import { CatalogModule } from 'catalog/catalog.module';
import { DbConfigModule, OrmConfigModule } from 'shared/config';
import { FirebaseProvider } from 'shared/providers';

@Module({
  imports: [DbConfigModule, OrmConfigModule, AuthModule, CatalogModule],
  providers: [FirebaseProvider],
})
export class AppModule {}
