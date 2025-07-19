import { Request } from 'express';
import { Deck } from 'authoring/core/entities';
import { User } from 'shared/auth/entities';

declare module 'express' {
  interface Request {
    ssoId: string;
    user: User;
    deck?: Deck;
  }
}
