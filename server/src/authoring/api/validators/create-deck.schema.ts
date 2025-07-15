import { z } from 'zod';
import { QUESTION_TYPE_NAMES } from 'shared/constants';

const createAnswerOptionSchema = z.object({
  text: z.string().max(120),
  isCorrect: z.boolean(),
});

const createQuestionSchema = z.object({
  text: z.string(),
  answer: z.string().optional(),
  questionType: z.enum(QUESTION_TYPE_NAMES),
  answerOptions: z.array(createAnswerOptionSchema).optional(),
});

export const createDeckSchema = z.object({
  title: z.string().max(50),
  description: z.string().max(300),
  questions: z.array(createQuestionSchema),
});
