import { z } from 'zod';
import { QUESTION_TYPE_NAMES } from 'shared/constants';

const answerOptionSchema = z.object({
  text: z.string().max(120),
  isCorrect: z.boolean(),
});

const questionSchema = z.object({
  text: z.string(),
  answer: z.string().nullable().optional(),
  questionType: z.enum(QUESTION_TYPE_NAMES),
  answerOptions: z.array(answerOptionSchema).nullable().optional(),
});

export const deckSchema = z.object({
  title: z.string().max(50),
  description: z.string().max(300),
  questions: z.array(questionSchema),
});
