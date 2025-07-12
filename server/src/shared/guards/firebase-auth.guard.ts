import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { Request } from 'express';
import * as firebaseAdmin from 'firebase-admin';

@Injectable()
export class FirebaseAuthGuard implements CanActivate {
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
      return true;
    } catch (error) {
      console.log(error);
      throw new UnauthorizedException('Failed to authenticate.');
    }
  }
}

export const FirebaseAuthGuardProvider = {
  provide: APP_GUARD,
  useClass: FirebaseAuthGuard,
};
