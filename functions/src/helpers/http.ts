import { Request } from 'firebase-functions/v2/https';
import { Response } from 'firebase-functions/v1';

type ErrorResponse = {
  res: Response;
  statusCode: number;
  message: string;
};
export function sendErrorResponse({ res, statusCode, message }: ErrorResponse) {
  res.status(statusCode).send({ error: message });
}

export function verifyRequestMethod(
  method: string,
  req: Request,
  res: Response,
) {
  if (req.method === method) return;
  sendErrorResponse({
    res,
    statusCode: 405,
    message: `Method not allowed, use ${method}.`,
  });
}

export function verifyRequestPdf(req: Request, res: Response) {
  if (req.rawBody && req.rawBody.length !== 0) return;
  sendErrorResponse({
    res,
    statusCode: 400,
    message: 'Missing PDF file in request body.',
  });
}

export function verifyContentType(
  contentType: string,
  req: Request,
  res: Response,
) {
  if (!req.get('content-type')?.includes(contentType)) return;
  sendErrorResponse({
    res,
    statusCode: 415,
    message: `Content-Type must include ${contentType}.`,
  });
}
