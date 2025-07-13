import { Request } from 'express';
import { User } from 'shared/auth/entities';

declare module 'express' {
  interface Request {
    ssoId: string;
    user: User;
  }
}
