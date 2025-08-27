import 'dotenv/config';

export const config = {
  PERFORMANCE_ANALYSIS_MODEL:
    process.env.PERFORMANCE_ANALYSIS_MODEL || 'gpt-4-turbo',
};

export const PERFORMANCE_ANALYSIS_PROMPT = ``;
