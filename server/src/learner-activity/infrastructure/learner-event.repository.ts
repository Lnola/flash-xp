import { EntityManager } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';

@Injectable()
export class LearnerEventRepository extends BaseEntityRepository<LearnerEvent> {
  constructor(protected readonly em: EntityManager) {
    super(em, LearnerEvent);
  }
}
