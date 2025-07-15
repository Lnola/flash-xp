import { EntityManager } from '@mikro-orm/core';
import { Injectable, OnModuleInit } from '@nestjs/common';
import { QuestionType } from 'authoring/core/entities';

@Injectable()
export class QuestionTypeProvider implements OnModuleInit {
  private readonly questionTypesMap = new Map<string, QuestionType>();

  constructor(private readonly em: EntityManager) {}

  async onModuleInit() {
    const em = this.em.fork();
    const questionTypes = await em.findAll(QuestionType);
    questionTypes.forEach((questionType) => {
      this.questionTypesMap.set(questionType.name, questionType);
    });
  }

  getByName(name: string): QuestionType | undefined {
    return this.questionTypesMap.get(name);
  }
}
