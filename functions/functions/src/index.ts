import { logger } from 'firebase-functions';
import { onRequest } from 'firebase-functions/v2/https';
import { initializeApp } from 'firebase-admin/app';

initializeApp();

export const uppercase = onRequest(async (req, res) => {
  const original = req.query.text;
  if (!original || typeof original !== 'string') {
    res.status(400).send('Incorrect or missing "text" parameter.');
    return;
  }
  logger.log('Uppercasing', original);
  const uppercase = original.toUpperCase();
  res.json({ result: uppercase });
});
