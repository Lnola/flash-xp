export type Flashcard = {
  question: string;
  answer: string;
};

export const FLASHCARD_PROMPT = `Create a list of flashcards from the following text. 
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "questionType": { "name": "Self Assessment" }, "answer": "..." },
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
The questions need to have exactly 4 possible answers where one of them is correct while the others are incorrect. Randomize the correct option position, don't keep it in the same place always.
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "questionType": { "name": "Multiple Choice" }, "answerOptions": [{ "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }, { "text": "...", "isCorrect": <boolean> }] },
  ...
]`;

export const QuestionType = {
  Flashcards: {
    prompt: FLASHCARD_PROMPT,
  },
  'Multiple Choice': {
    prompt: MULTIPLE_CHOICE_PROMPT,
  },
} as const;
export type QuestionTypeKey = keyof typeof QuestionType;
export type QuestionType = (typeof QuestionType)[QuestionTypeKey];
