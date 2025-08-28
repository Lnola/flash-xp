import { Migration } from '@mikro-orm/migrations';

const PRACTICE_PROGRESS_VIEW = 'practice_progress_view';
const WEIGHTS = [0, 0.25, 0.5, 0.75, 1];
const ROUNDING_PRECISION = 2;

export class CreatePracticeProgressView extends Migration {
  override up(): void {
    const weights = WEIGHTS.map(
      (value, index) => `(${index + 1}, ${value})`,
    ).join(', ');
    const createPracticeProgressView = `
      CREATE OR REPLACE VIEW ${PRACTICE_PROGRESS_VIEW} AS
      WITH weights AS (
        SELECT * 
        FROM (VALUES ${weights}) AS t (index, value)
      ),
      question_count_per_box AS (
        SELECT
          box.learner_id,
          box.deck_id,
          box.index,
          COUNT(*) AS count
        FROM box
        GROUP BY box.learner_id, box.deck_id, box.index
      ),
      question_progress_per_box AS (
        SELECT
          qc.learner_id,
          qc.deck_id,
          qc.index,
          qc.count, 
          (w.value * qc.count) AS progress
        FROM question_count_per_box AS qc
        LEFT JOIN weights AS w
        ON w.index = qc.index
      )
      SELECT 
        qp.learner_id,
        qp.deck_id,
        ROUND(SUM(qp.progress) / SUM(qp.count) * 100, ${ROUNDING_PRECISION}) AS progress
      FROM question_progress_per_box AS qp
      GROUP BY qp.learner_id, qp.deck_id;`;
    this.addSql(createPracticeProgressView);
  }

  override down(): void {
    const knex = this.getKnex();
    const dropPracticeProgressView = knex.schema.dropView(
      PRACTICE_PROGRESS_VIEW,
    );
    this.addSql(dropPracticeProgressView.toQuery());
  }
}
