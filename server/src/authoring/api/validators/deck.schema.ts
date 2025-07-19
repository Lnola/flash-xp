import { z } from 'zod';
import { QUESTION_TYPE_NAMES } from 'shared/constants';

const answerOptionSchema = z.object({
  text: z.string().max(120),
  isCorrect: z.boolean(),
});

const atLeastOneAnswerOptionCorrect = (
  answerOptions: Array<{ text: string; isCorrect: boolean }> | null | undefined,
) => {
  if (!answerOptions) return true;
  return answerOptions.some((option) => option.isCorrect);
};
const questionSchema = z.object({
  text: z.string(),
  answer: z.string().nullable().optional(),
  questionType: z.enum(QUESTION_TYPE_NAMES),
  answerOptions: z
    .array(answerOptionSchema)
    .nullable()
    .optional()
    .refine(atLeastOneAnswerOptionCorrect, {
      message: 'At least one answer option must be correct.',
    }),
});

export const deckSchema = z.object({
  title: z.string().max(50),
  description: z.string().max(300),
  questions: z.array(questionSchema),
});
