import { Module } from '@nestjs/common';
import { CatalogExternalModule } from 'catalog/external';
import { CatalogIntegrationService } from './catalog-integration.service';

@Module({
  imports: [CatalogExternalModule],
  providers: [CatalogIntegrationService],
  exports: [CatalogIntegrationService],
})
export class CatalogIntegrationModule {}
