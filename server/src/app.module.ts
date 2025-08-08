import { Module } from '@nestjs/common';
import { AuthoringModule } from 'authoring/authoring.module';
import { CatalogModule } from 'catalog/catalog.module';
import { PracticeModule } from 'practice/practice.module';
import { AuthModule } from 'shared/auth/auth.module';
import { DbConfigModule, OrmConfigModule } from 'shared/config';
import { FirebaseProvider } from 'shared/providers';

@Module({
  imports: [
    DbConfigModule,
    OrmConfigModule,
    AuthModule,
    CatalogModule,
    AuthoringModule,
    PracticeModule,
  ],
  providers: [FirebaseProvider],
})
export class AppModule {}
