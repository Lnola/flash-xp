import 'dotenv/config';

export const PERFORMANCE_ANALYSIS_PROMPT = `You are an expert educational consultant.
Analyze the learner's performance based on the provided accuracy rates and question type occurrence counts. 
Provide insights into strengths and weaknesses, and suggest strategies for improvement. 
Focus on areas such as understanding of material, test-taking skills, and areas needing further study. 
Be concise and actionable in your recommendations.
Format your response in clear paragraphs.
Do not include any markdown formatting or similar.`;

export const config = {
  performanceAnalysisPrompt: PERFORMANCE_ANALYSIS_PROMPT,
  performanceAnalysisModel:
    process.env.PERFORMANCE_ANALYSIS_MODEL || 'gpt-4-turbo',
};
