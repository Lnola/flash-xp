import { EntityManager } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { startOfDay } from 'date-fns';
import {
  AccuracyRate,
  DailyCorrectIncorrect,
} from 'learner-activity/core/models';

@Injectable()
export class LearnerStatisticsRepository {
  constructor(protected readonly em: EntityManager) {}

  async getDailyStreak(learnerId: number): Promise<number> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();
    const daysCte = knex
      .select(knex.raw('DATE(created_at) AS day'))
      .from('learner_event')
      .where('learner_id', learnerId)
      .andWhereRaw('DATE(created_at) <= CURRENT_DATE')
      .distinct();
    const indexedDaysCte = knex
      .select('day')
      .select(knex.raw('ROW_NUMBER() OVER (ORDER BY day DESC) AS rn'))
      .from('days');
    const rows: { streak: number }[] = await knex
      .with('days', daysCte)
      .with('indexed_days', indexedDaysCte)
      .select({ streak: knex.raw('COUNT(*)') })
      .from('indexed_days')
      .whereRaw(`day >= CURRENT_DATE - (rn - 1) * INTERVAL '1 day'`);

    return rows[0]?.streak || 0;
  }

  async getAnswerCount(learnerId: number, interval?: number): Promise<number> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();
    const query = knex('learner_event')
      .count('*')
      .where({ learner_id: learnerId });

    if (interval) {
      const from = new Date();
      from.setDate(from.getDate() - interval + 1);
      query.andWhere('created_at', '>=', startOfDay(from));
    }
    const result = (await query) as { count: number }[];
    return result[0].count || 0;
  }

  async getDeckCount(learnerId: number, interval?: number): Promise<number> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();
    const query = knex('learner_event')
      .countDistinct(knex.raw(`payload->>'deckId'`))
      .where({ learner_id: learnerId });

    if (interval) {
      const from = new Date();
      from.setDate(from.getDate() - interval + 1);
      query.andWhere('created_at', '>=', startOfDay(from));
    }
    const result = (await query) as { count: number }[];
    return result[0].count || 0;
  }

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

  async getAccuracyRate(learnerId: number): Promise<AccuracyRate> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();
    const correct = knex.raw(
      `COUNT(*) FILTER (WHERE (payload ->> 'isCorrect')::boolean = TRUE)`,
    );
    const total = knex.raw(`COUNT(*)`);
    const rows = await knex
      .select({ correct, total })
      .from('learner_event')
      .where({ learner_id: learnerId });

    return new AccuracyRate(rows[0] as AccuracyRate);
  }

  async getCommonIncorrectlyAnsweredQuestionIds(
    learnerId: number,
  ): Promise<Array<{ questionId: number; count: number }>> {
    const knex = this.em.getKnex();
    const rows = await knex
      .select({
        questionId: knex.raw(`(payload->>'questionId')::int`),
        count: knex.raw(`COUNT(*)`),
      })
      .from('learner_event')
      .where({ learner_id: learnerId })
      .andWhere(knex.raw(`(payload->>'isCorrect')::boolean = FALSE`))
      .groupBy('questionId')
      .havingRaw(`COUNT(*) > 3`)
      .orderBy('count', 'desc')
      .limit(3);

    return rows as Array<{ questionId: number; count: number }>;
  }

  async getAnsweredQuestionIds(learnerId: number): Promise<number[]> {
    if (learnerId == null) throw new Error('learnerId required');

    const knex = this.em.getKnex();
    const result = await knex('learner_event')
      .select({ questionId: knex.raw(`(payload->>'questionId')::int`) })
      .where({ learner_id: learnerId })
      .distinct();

    return result.map((row: { questionId: number }) => row.questionId);
  }
}
