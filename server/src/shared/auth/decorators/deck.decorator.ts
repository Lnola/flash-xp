import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';
import { Deck as DeckEntity } from 'authoring/core/entities';

// TODO: think if this decorator should be in the auth module or shared module
export const Deck = createParamDecorator(
  (field: keyof DeckEntity, context: ExecutionContext) => {
    const request = context.switchToHttp().getRequest<Request>();
    const deck = request.deck;
    if (!deck) throw new Error('Deck not found in request');
    return field ? deck[field] : deck;
  },
);
