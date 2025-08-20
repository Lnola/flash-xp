import { Module } from '@nestjs/common';
import { AuthoringModule } from 'authoring/authoring.module';
import { CatalogModule } from 'catalog/catalog.module';
import { PracticeModule } from 'practice/practice.module';
import { AuthModule } from 'shared/auth/auth.module';
import { DbConfigModule, OrmConfigModule } from 'shared/config';
import { MediatorModule } from 'shared/mediator/mediator.module';
import { FirebaseProvider } from 'shared/providers';

@Module({
  imports: [
    DbConfigModule,
    OrmConfigModule,
    AuthModule,
    MediatorModule,
    CatalogModule,
    AuthoringModule,
    PracticeModule,
  ],
  providers: [FirebaseProvider],
})
export class AppModule {}
