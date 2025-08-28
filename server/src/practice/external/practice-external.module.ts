import { Module } from '@nestjs/common';
import { PracticeModule } from 'practice/practice.module';
import { PracticeExternalService } from './practice-external.service';

@Module({
  imports: [PracticeModule],
  providers: [PracticeExternalService],
  exports: [PracticeExternalService],
})
export class PracticeExternalModule {}
