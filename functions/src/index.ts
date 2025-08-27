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
  verifyQuestionType,
} from './generate-questions/question-type';
import { PerformanceAnalyser } from './analyse-performance';
import {
  verifyAccuracyRate,
  verifyQuestionTypeOccurrenceCount,
} from './analyse-performance/validators';
import {
  AccuracyRate,
  QuestionTypeOccurrenceCount,
} from './analyse-performance/types';

initializeApp();

// This is not secured with auth, but could be easily implemented using Firebase Auth.
export const generateQuestions = onRequest(async (req, res) => {
  try {
    verifyRequestMethod('POST', req);
    verifyContentType('application/pdf', req);
    verifyRequestPdf(req);

    verifyQuestionType(req.query.type as string);
    const type = req.query.type as QuestionTypeKey;

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

export const analysePerformance = onRequest(async (req, res) => {
  try {
    verifyRequestMethod('GET', req);

    const accuracyRate = JSON.parse(
      req.query.accuracyRate as string,
    ) as AccuracyRate;
    const multipleChoiceAccuracyRate = JSON.parse(
      req.query.multipleChoiceAccuracyRate as string,
    ) as AccuracyRate;
    const selfAssessmentAccuracyRate = JSON.parse(
      req.query.selfAssessmentAccuracyRate as string,
    ) as AccuracyRate;
    const questionTypeOccurrenceCount = JSON.parse(
      req.query.questionTypeOccurrenceCount as string,
    ) as QuestionTypeOccurrenceCount;

    verifyAccuracyRate(accuracyRate);
    verifyAccuracyRate(multipleChoiceAccuracyRate);
    verifyAccuracyRate(selfAssessmentAccuracyRate);
    verifyQuestionTypeOccurrenceCount(questionTypeOccurrenceCount);

    const performanceAnalyser = new PerformanceAnalyser({
      accuracyRate,
      multipleChoiceAccuracyRate,
      selfAssessmentAccuracyRate,
      questionTypeOccurrenceCount,
    });
    const analysis = performanceAnalyser.analyse();

    res.json({ analysis });
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
