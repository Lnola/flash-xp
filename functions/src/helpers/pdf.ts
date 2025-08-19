import pdfParse from 'pdf-parse';
import { HttpError } from './http';

export async function extractTextFromPdf(pdfBuffer: Buffer) {
  const data = await pdfParse(pdfBuffer);
  const fullText = data.text || '';
  if (!fullText.trim()) {
    throw new HttpError(400, 'No extractable text found in PDF.');
  }
  return fullText;
}
