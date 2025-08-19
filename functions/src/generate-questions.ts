#!/usr/bin/env node
import 'dotenv/config';
// import fs from 'fs';
// import path from 'path';
// bypass the pdf-parse test stub
import pdfParse from 'pdf-parse';
import OpenAI from 'openai';
import { logger } from 'firebase-functions';
import { HttpError } from './helpers/http';

// const PDF_PATH = path.resolve('./pdfs/example.pdf');
// const OUT_DIR = path.resolve('flashcards');
// const OUT_FILE = path.join(OUT_DIR, 'summarized.json');
const CHUNK_SIZE = 6000; // chars per summarization chunk
const SUMMARY_MODEL = 'gpt-3.5-turbo';
const FLASH_MODEL = 'gpt-4-turbo';

// async function readPdf() {
//   if (!fs.existsSync(PDF_PATH)) {
//     console.error(`❌ PDF not found at ${PDF_PATH}`);
//     process.exit(1);
//   }
//   const data = fs.readFileSync(PDF_PATH);
//   const { text } = await pdfParse(data);
//   return text || '';
// }

async function summarizeText(openai: OpenAI, fullText: string) {
  // split into fixed-size chunks
  const chunks = [];
  for (let i = 0; i < fullText.length; i += CHUNK_SIZE) {
    chunks.push(fullText.slice(i, i + CHUNK_SIZE));
  }

  console.log(
    `🔀 Summarizing ${chunks.length} chunk(s) with ${SUMMARY_MODEL}…`,
  );
  const summaries = [];
  for (let i = 0; i < chunks.length; i++) {
    const chunk = chunks[i];
    console.log(`  • chunk ${i + 1}/${chunks.length}`);
    const resp = await openai.chat.completions.create({
      model: SUMMARY_MODEL,
      messages: [
        {
          role: 'system',
          content: `Summarize the following text into 5 concise bullet points.`,
        },
        { role: 'user', content: chunk },
      ],
    });
    if (
      !resp.choices ||
      resp.choices.length === 0 ||
      !resp.choices[0].message.content
    ) {
      throw new Error('No response from GPT');
    }
    summaries.push(resp.choices[0].message.content.trim());
  }

  // join bullet lists into one distillation
  return summaries.join('\n\n');
}

async function generateFlashcards(openai: OpenAI, distilled: string) {
  console.log(
    `📤 Generating flashcards from distilled summary with ${FLASH_MODEL}…`,
  );
  const prompt = `
Create a list of flashcards from the following text.
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "answer": "..." },
  ...
]
`.trim();

  const resp = await openai.chat.completions.create({
    model: FLASH_MODEL,
    messages: [
      { role: 'system', content: prompt },
      { role: 'user', content: distilled },
    ],
  });

  const content = resp.choices[0].message.content;
  if (!content || typeof content !== 'string') {
    throw new Error('Invalid response from GPT');
  }
  const start = content.indexOf('[');
  const end = content.lastIndexOf(']');
  if (start < 0 || end < 0) {
    throw new Error('Invalid JSON response from GPT');
  }
  return JSON.parse(content.slice(start, end + 1));
}

// async function main() {
//   if (!process.env.OPENAI_API_KEY) {
//     console.error('❌ Missing OPENAI_API_KEY in .env');
//     process.exit(1);
//   }

//   // 1) extract raw text
//   const fullText = await readPdf();
//   if (!fullText.trim()) {
//     console.error('❌ No extractable text found in example.pdf');
//     process.exit(1);
//   }

//   // 2) summarize
//   const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
//   const distilled = await summarizeText(openai, fullText);

//   // 3) flashcards from summary
//   let cards = [];
//   try {
//     cards = await generateFlashcards(openai, distilled);
//     console.log(`✅ GPT returned ${cards.length} cards`);
//   } catch (err) {
//     console.error('❌ Flashcard generation failed:', err);
//     process.exit(1);
//   }

//   // 4) dedupe
//   const unique = Array.from(
//     new Map(cards.map((c: Flashcard) => [c.question.trim(), c])).values()
//   );

//   // 5) save
//   fs.mkdirSync(OUT_DIR, { recursive: true });
//   fs.writeFileSync(OUT_FILE, JSON.stringify(unique, null, 2), 'utf8');
//   console.log(`🎉 Saved ${unique.length} unique flashcards to ${OUT_FILE}`);
// }

export async function otherFunction(pdfBuffer: Buffer) {
  // Placeholder for other functionality
  const data = await pdfParse(pdfBuffer);
  const fullText = data.text || '';

  if (!fullText.trim()) {
    console.error('❌ No extractable text found in example.pdf');
    process.exit(1);
  }

  // 2) summarize
  const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  const distilled = await summarizeText(openai, fullText);

  // 3) flashcards from summary
  let cards = [];
  try {
    cards = await generateFlashcards(openai, distilled);
    console.log(`✅ GPT returned ${cards.length} cards`);
  } catch (err) {
    console.error('❌ Flashcard generation failed:', err);
    process.exit(1);
  }

  // 4) dedupe
  const unique = Array.from(
    new Map(cards.map((c: Flashcard) => [c.question.trim(), c])).values(),
  );

  return { questions: unique };
}

// main().catch((err) => {
//   console.error('❌ Unexpected error:', err);
//   process.exit(1);
// });

type Flashcard = {
  question: string;
  answer: string;
};

export async function summarizeAndGenerate(pdfBuffer: Buffer) {
  // Placeholder implementation: parse text and generate dummy questions
  const data = await pdfParse(pdfBuffer);
  const text = data.text;

  logger.info(text);
  const questions = await otherFunction(pdfBuffer);
  return { questions };
}

export class QuestionGenerator {
  private ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  private static CHUNK_SIZE = parseInt(process.env.CHUNK_SIZE || '6000', 10);
  private static SUMMARY_MODEL = process.env.SUMMARY_MODEL || 'gpt-3.5-turbo';

  private _chunkText(text: string, chunkSize: number): string[] {
    const chunks = [];
    for (let i = 0; i < text.length; i += chunkSize) {
      chunks.push(text.slice(i, i + chunkSize));
    }
    return chunks;
  }

  private async _getAiSummary(chunk: string, model: string): Promise<string> {
    const response = await this.ai.chat.completions.create({
      model,
      messages: [
        {
          role: 'system',
          content: `Summarize the following text into concise bullet points.`,
        },
        {
          role: 'user',
          content: chunk,
        },
      ],
    });
    if (
      !response.choices ||
      response.choices.length === 0 ||
      !response.choices[0].message.content
    ) {
      throw new HttpError(403, 'No response from GPT');
    }
    return response.choices[0].message.content;
  }

  async summarizeText(text: string): Promise<string> {
    const chunks = this._chunkText(text, QuestionGenerator.CHUNK_SIZE);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${QuestionGenerator.SUMMARY_MODEL}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this._getAiSummary(chunk, QuestionGenerator.SUMMARY_MODEL);
    });
    const summaries = await Promise.all(summaryPromises);
    return summaries.join('\n\n');
  }
}
