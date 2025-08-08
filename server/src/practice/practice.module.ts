import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { QuickPracticeController } from './api';
import { QuickPracticeService } from './core/services';

@Module({
  imports: [MikroOrmModule.forFeature([])],
  providers: [QuickPracticeService],
  controllers: [QuickPracticeController],
})
export class PracticeModule {}
