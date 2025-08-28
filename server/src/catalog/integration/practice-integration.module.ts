import { Module } from '@nestjs/common';
import { PracticeExternalModule } from 'practice/external';
import { PracticeIntegrationService } from './practice-integration.service';

@Module({
  imports: [PracticeExternalModule],
  providers: [PracticeIntegrationService],
  exports: [PracticeIntegrationService],
})
export class PracticeIntegrationModule {}
