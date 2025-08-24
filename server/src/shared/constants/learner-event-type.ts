export const LearnerEventTypes = {
  ANSWER_SUBMITTED: 'ANSWER_SUBMITTED',
} as const;

export type LearnerEventType = keyof typeof LearnerEventTypes;
