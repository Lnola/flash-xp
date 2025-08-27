import { Module } from '@nestjs/common';
import { CatalogModule } from 'catalog/catalog.module';
import { CatalogExternalService } from './catalog-external.service';

@Module({
  imports: [CatalogModule],
  providers: [CatalogExternalService],
  exports: [CatalogExternalService],
})
export class CatalogExternalModule {}
