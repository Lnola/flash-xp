import { InjectRepository } from '@mikro-orm/nestjs';
import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { Request } from 'express';
import * as firebaseAdmin from 'firebase-admin';
import { BaseEntityRepository } from 'shared/database/base.repository';
import { User } from 'shared/entities';

@Injectable()
export class FirebaseAuthGuard implements CanActivate {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: BaseEntityRepository<User>,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<Request>();
    const authHeader = request.headers.authorization;
    if (!authHeader?.startsWith('Bearer ')) {
      throw new UnauthorizedException('Failed to authenticate.');
    }
    try {
      const idToken = authHeader.split('Bearer ')[1];
      const decodedToken = await firebaseAdmin.auth().verifyIdToken(idToken);
      request.ssoId = decodedToken.uid;

      const user = await this.userRepository.findOne({
        ssoId: decodedToken.uid,
      });
      if (user) {
        request.user = user;
        return true;
      }
      const newUser = new User({ ssoId: decodedToken.uid });
      await this.userRepository.persistAndFlush(newUser);
      request.user = newUser;
      return true;
    } catch {
      throw new UnauthorizedException('Failed to authenticate.');
    }
  }
}

export const FirebaseAuthGuardProvider = {
  provide: APP_GUARD,
  useClass: FirebaseAuthGuard,
};
