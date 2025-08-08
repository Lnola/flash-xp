import { Controller } from '@nestjs/common';
import { QuickPracticeService } from 'practice/core/services';

@Controller('practice/quick')
export class QuickPracticeController {
  constructor(private readonly quickPracticeService: QuickPracticeService) {}
}
