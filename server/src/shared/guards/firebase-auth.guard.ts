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
    try {
      const ssoId = await this._verifyFirebaseUser(request);
      request.ssoId = ssoId;
      const user = await this._verifyDatabaseUser(ssoId);
      request.user = user;
      return true;
    } catch {
      throw new UnauthorizedException('Failed to authenticate.');
    }
  }

  async _verifyFirebaseUser(request: Request): Promise<string> {
    const authHeader = request.headers.authorization;
    if (!authHeader?.startsWith('Bearer ')) {
      throw new UnauthorizedException('Failed to authenticate.');
    }
    const idToken = authHeader.split('Bearer ')[1];
    const decodedToken = await firebaseAdmin.auth().verifyIdToken(idToken);
    return decodedToken.uid;
  }

  async _verifyDatabaseUser(ssoId: string): Promise<User> {
    const user = await this.userRepository.findOne({ ssoId });
    if (!user) {
      const newUser = new User({ ssoId });
      await this.userRepository.persistAndFlush(newUser);
      return newUser;
    }
    return user;
  }
}

// TODO: move this to the auth module
export const FirebaseAuthGuardProvider = {
  provide: APP_GUARD,
  useClass: FirebaseAuthGuard,
};
