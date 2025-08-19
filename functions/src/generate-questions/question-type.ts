import { HttpError } from '../helpers/http';

export type Flashcard = {
  question: string;
  answer: string;
};

export const FLASHCARD_PROMPT = `Create a list of flashcards from the following text. 
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "answer": "..." },
  ...
]`;

export type MultipleChoice = {
  question: string;
  answerOptions: {
    text: string;
    isCorrect: boolean;
  };
};

export const MULTIPLE_CHOICE_PROMPT = `Create a list of multiple choice questions from the following text. 
The questions need to have exactly 4 possible answers where one of them is correct while the others are incorrect. 
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "answerOptions": [{ "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }] },
  ...
]`;

export const QuestionType = {
  flashcard: {
    prompt: FLASHCARD_PROMPT,
  },
  multipleChoice: {
    prompt: MULTIPLE_CHOICE_PROMPT,
  },
} as const;
export type QuestionTypeKey = keyof typeof QuestionType;
export type QuestionType = (typeof QuestionType)[QuestionTypeKey];

export function verifyQuestionType(
  type: string,
): asserts type is QuestionTypeKey {
  if (!(type in QuestionType)) {
    throw new HttpError(400, `Invalid question type: ${type}`);
  }
}
