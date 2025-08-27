import 'dotenv/config';
import OpenAI from 'openai';
import { HttpError } from '../helpers/http';

export class Ai {
  private ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

  async call({ model, messages }: CallAiOptions): Promise<string> {
    const response = await this.ai.chat.completions.create({ model, messages });
    if (
      !response.choices ||
      response.choices.length === 0 ||
      !response.choices[0].message.content
    ) {
      throw new HttpError(403, 'No response from GPT');
    }
    return response.choices[0].message.content;
  }
}

type CallAiOptions =
  OpenAI.Chat.Completions.ChatCompletionCreateParamsNonStreaming;
