import { InjectRepository } from '@mikro-orm/nestjs';
import { Injectable } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';

@Injectable()
export class QuickPracticeService {
  constructor(
    @InjectRepository(PracticeQuestion)
    private readonly practiceQuestionRepository: BaseEntityRepository<PracticeQuestion>,
  ) {}
}
