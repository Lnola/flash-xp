import { EntityManager, QueryOrder } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { Box } from 'practice/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';

@Injectable()
export class BoxRepository extends BaseEntityRepository<Box> {
  constructor(protected readonly em: EntityManager) {
    super(em, Box);
  }

  async findPopularDeckIds(): Promise<number[]> {
    const knex = this.getKnex();
    const rows = await knex('box')
      .select({
        deckId: 'deck_id',
        count: knex.raw('COUNT(DISTINCT(learner_id))::int'),
      })
      .where('index', '>', 1)
      .groupBy('deck_id')
      .orderBy('count', QueryOrder.DESC)
      .limit(10);

    return rows.map((it: { deckId: number }) => it.deckId);
  }
}
