import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';
import { logger } from 'firebase-functions';
import {
  verifyContentType,
  verifyRequestPdf,
  verifyRequestMethod,
  HttpError,
} from './helpers/http';
import { extractTextFromPdf } from './helpers/pdf';
import { QuestionGenerator } from './generate-questions';
import {
  QuestionType,
  QuestionTypeKey,
} from './generate-questions/question-type';

initializeApp();

// TODO: add the option to do either flashcards or multiple choice questions
export const generateQuestions = onRequest(async (req, res) => {
  verifyRequestMethod('POST', req);
  verifyContentType('application/pdf', req);
  verifyRequestPdf(req);

  const type = req.query.type as QuestionTypeKey;

  try {
    const pdfBuffer = Buffer.from(req.rawBody);
    const fullText = await extractTextFromPdf(pdfBuffer);

    const questionGenerator = new QuestionGenerator(QuestionType[type]);
    const summarizedText = await questionGenerator.summarizeText(fullText);
    const questions = await questionGenerator.generate(summarizedText);

    res.json(questions);
  } catch (error) {
    if (error instanceof HttpError) {
      logger.error(`HTTP Error: ${error.message}`);
      res.status(error.statusCode).send(error.message);
      return;
    }
    logger.error(`Error: ${error}`);
    res.status(500).send('Failed to process PDF.');
  }
});
