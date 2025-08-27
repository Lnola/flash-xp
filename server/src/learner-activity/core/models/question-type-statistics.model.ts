export class QuestionTypeStatistics {
  multipleChoiceCount!: number;
  selfAssessmentCount!: number;

  constructor({ multipleChoiceCount, selfAssessmentCount }: ConstructorProps) {
    this.multipleChoiceCount = Number(multipleChoiceCount);
    this.selfAssessmentCount = Number(selfAssessmentCount);
  }
}

type ConstructorProps = {
  multipleChoiceCount: number;
  selfAssessmentCount: number;
};
