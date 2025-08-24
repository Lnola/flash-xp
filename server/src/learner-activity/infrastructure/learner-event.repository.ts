import { EntityManager } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { LearnerEvent } from 'learner-activity/core/entities';
import { DailyCorrectIncorrect } from 'learner-activity/core/models';
import { BaseEntityRepository } from 'shared/database/base.repository';

// TODO: rename to statistics
@Injectable()
export class LearnerEventRepository extends BaseEntityRepository<LearnerEvent> {
  constructor(protected readonly em: EntityManager) {
    super(em, LearnerEvent);
  }

  async getDailyCorrectIncorrect(
    learnerId: number,
    numberOfDays: number = 7,
  ): Promise<DailyCorrectIncorrect[]> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.getKnex();
    const rows = await knex<DailyCorrectIncorrect>('learner_event')
      .select({
        day: knex.raw(`TO_CHAR(created_at, 'Dy')`),
        correct: knex.raw(
          `COUNT(*) FILTER (WHERE (payload->>'isCorrect')::boolean = TRUE)`,
        ),
        incorrect: knex.raw(
          `COUNT(*) FILTER (WHERE (payload->>'isCorrect')::boolean = FALSE)`,
        ),
      })
      .where('learner_id', learnerId)
      .andWhereRaw(`created_at >= NOW() - INTERVAL '${numberOfDays} days'`)
      .groupBy('day')
      .orderBy('day', 'asc');

    return rows.map((row) => new DailyCorrectIncorrect(row));
  }
}
