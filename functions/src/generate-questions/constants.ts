export const config = {
  CHUNK_SIZE: parseInt(process.env.CHUNK_SIZE || '6000', 10),
  SUMMARY_MODEL: process.env.SUMMARY_MODEL || 'gpt-3.5-turbo',
  QUESTION_MODEL: process.env.QUESTION_MODEL || 'gpt-4-turbo',
};
