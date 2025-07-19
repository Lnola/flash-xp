import { InjectRepository } from '@mikro-orm/nestjs';
import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { Deck } from 'authoring/core/entities';
import { BaseEntityRepository } from 'shared/database/base.repository';

@Injectable()
export class IsAuthorGuard implements CanActivate {
  constructor(
    @InjectRepository(Deck)
    private readonly deckRepository: BaseEntityRepository<Deck>,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<Request>();
    const userId = request.user.id;
    const deckId = +request.params.id;

    const deck = await this.deckRepository.findOne(deckId);
    if (!deck) return false;
    if (deck.authorId !== userId) return false;

    request.deck = deck;
    return true;
  }
}
