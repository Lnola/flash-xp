export const QUESTION_TYPE_NAMES = [
  'Multiple Choice',
  'Self Assessment',
] as const;

export const QUESTION_TYPE_MAP = {
  multipleChoice: QUESTION_TYPE_NAMES[0],
  selfAssessment: QUESTION_TYPE_NAMES[1],
} as const;
