import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';
import pdfParse from 'pdf-parse';
import { logger } from 'firebase-functions';
import {
  sendErrorResponse,
  verifyContentType,
  verifyRequestPdf,
  verifyRequestMethod,
} from './helpers/http';

initializeApp();

async function summarizeAndGenerate(pdfBuffer: Buffer) {
  // Placeholder implementation: parse text and generate dummy questions
  const data = await pdfParse(pdfBuffer);
  const text = data.text;

  logger.info(text);
  const questions = {
    question: `Question...`,
    answer: 'Answer...',
  };
  return { questions };
}

export const summarizePdf = onRequest(async (req, res) => {
  verifyRequestMethod('POST', req, res);
  verifyRequestPdf(req, res);
  verifyContentType('application/pdf', req, res);

  try {
    const pdfBuffer = Buffer.from(req.rawBody);
    const result = await summarizeAndGenerate(pdfBuffer);
    res.json(result);
  } catch (error) {
    if (error instanceof Error) {
      logger.error('Error processing PDF:', error.message);
    }
    sendErrorResponse({
      res,
      statusCode: 500,
      message: 'Failed to process PDF.',
    });
  }
});
