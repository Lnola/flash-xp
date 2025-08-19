import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';
import { logger } from 'firebase-functions';
import { summarizeAndGenerate } from './generate-questions';
import {
  verifyContentType,
  verifyRequestPdf,
  verifyRequestMethod,
  HttpError,
} from './helpers/http';
// import { extractTextFromPdf } from './helpers/pdf';

initializeApp();

// TODO: add the option to do either flashcards or multiple choice questions
export const generateQuestions = onRequest(async (req, res) => {
  verifyRequestMethod('POST', req);
  verifyContentType('application/pdf', req);
  verifyRequestPdf(req);

  try {
    const pdfBuffer = Buffer.from(req.rawBody);
    const result = await summarizeAndGenerate(pdfBuffer);
    res.json(result);
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
