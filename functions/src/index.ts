import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';
import { logger } from 'firebase-functions';
import { summarizeAndGenerate } from './generate-questions';
import {
  sendErrorResponse,
  verifyContentType,
  verifyRequestPdf,
  verifyRequestMethod,
} from './helpers/http';

initializeApp();

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
