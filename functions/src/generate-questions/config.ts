import 'dotenv/config';

const SUMMARY_PROMPT = `Summarize the following text into concise bullet points. Make sure to be thorough and cover all key aspects of the text. You are allowed to create as many bullets as you see fit.`;

export const config = {
  chunkSize: parseInt(process.env.CHUNK_SIZE || '6000', 10),
  summaryModel: process.env.SUMMARY_MODEL || 'gpt-3.5-turbo',
  summaryPrompt: SUMMARY_PROMPT,
  questionModel: process.env.QUESTION_MODEL || 'gpt-4-turbo',
};
