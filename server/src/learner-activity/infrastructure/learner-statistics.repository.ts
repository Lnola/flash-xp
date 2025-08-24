import { EntityManager } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { DailyCorrectIncorrect } from 'learner-activity/core/models';

@Injectable()
export class LearnerStatisticsRepository {
  constructor(protected readonly em: EntityManager) {}

  async getDailyCorrectIncorrect(
    learnerId: number,
    numberOfDays: number = 7,
  ): Promise<DailyCorrectIncorrect[]> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();

    const daysBack = Math.max(0, numberOfDays - 1);
    const daysCte = knex.raw(
      `SELECT generate_series(CURRENT_DATE - (${daysBack} || ' days')::interval, CURRENT_DATE, INTERVAL '1 day')::date AS day`,
    );
    const day = knex.raw(`TO_CHAR(days.day, 'Dy')`);
    const correct = knex.raw(
      `COALESCE(COUNT(*) FILTER (WHERE (learner_event.payload->>'isCorrect')::boolean = TRUE), 0)`,
    );
    const incorrect = knex.raw(
      `COALESCE(COUNT(*) FILTER (WHERE (learner_event.payload->>'isCorrect')::boolean = FALSE), 0)`,
    );
    const on = knex.raw(
      `DATE(learner_event.created_at) = days.day AND learner_event.learner_id = ${learnerId}`,
    );
    const rows = await knex
      .with('days', daysCte)
      .select({ day, correct, incorrect })
      .from('days')
      .leftJoin('learner_event', on)
      .groupBy('days.day')
      .orderBy('days.day', 'asc');

    return rows.map(
      (row: DailyCorrectIncorrect) => new DailyCorrectIncorrect(row),
    );
  }
}
