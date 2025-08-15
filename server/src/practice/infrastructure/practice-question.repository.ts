import { EntityManager, EntityRepository } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { PracticeQuestion } from 'practice/core/entities';

@Injectable()
export class PracticeQuestionRepository extends EntityRepository<PracticeQuestion> {
  constructor(protected readonly em: EntityManager) {
    super(em, PracticeQuestion);
  }

  async findWithNoBoxes(
    deckId: PracticeQuestion['deckId'],
    learnerId: number,
  ): Promise<PracticeQuestion[]> {
    const knex = this.getKnex();
    const boxIdsSubquery = knex('box')
      .select(1)
      .where('box.question_id', knex.ref('question.id'))
      .andWhere('box.learner_id', learnerId);
    const rows = await knex('question')
      .select('*')
      .where('question.deck_id', deckId)
      .whereNotExists(boxIdsSubquery);
    return rows.map((question: PracticeQuestion) =>
      this.getEntityManager().map(PracticeQuestion, question),
    );
  }
}
