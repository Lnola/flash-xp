import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';
import pdfParse from 'pdf-parse';
import { logger } from 'firebase-functions';

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
  if (req.method !== 'POST') {
    res.status(405).send({ error: 'Method not allowed, use POST.' });
    return;
  }

  if (!req.rawBody || req.rawBody.length === 0) {
    res.status(400).send({ error: 'Missing PDF file in request body.' });
    return;
  }

  const contentType = req.get('content-type') || '';
  if (!contentType.includes('application/pdf')) {
    res.status(400).send({ error: 'Content-Type must be application/pdf.' });
    return;
  }

  try {
    const pdfBuffer = Buffer.from(req.rawBody);
    const result = await summarizeAndGenerate(pdfBuffer);
    res.json(result);
  } catch (error) {
    if (error instanceof Error) {
      logger.log('Error processing PDF:', error.message);
    }
    res.status(500).send({ error: 'Failed to process PDF.' });
  }
});
