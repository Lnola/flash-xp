import { Request } from 'firebase-functions/v2/https';

export class HttpError extends Error {
  constructor(public statusCode: number, message: string) {
    super(message);
  }
}

export function verifyRequestMethod(method: string, req: Request) {
  if (req.method !== method) {
    throw new HttpError(405, `Method not allowed, use ${method}.`);
  }
}

export function verifyContentType(contentType: string, req: Request) {
  if (!req.get('content-type')?.includes(contentType)) {
    throw new HttpError(415, `Content-Type must include ${contentType}.`);
  }
}

export function verifyRequestPdf(req: Request) {
  if (!req.rawBody || req.rawBody.length === 0) {
    throw new HttpError(400, 'Missing PDF file in request body.');
  }
}
