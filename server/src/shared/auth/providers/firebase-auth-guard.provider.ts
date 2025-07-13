import { APP_GUARD } from '@nestjs/core';
import { FirebaseAuthGuard } from '../guards';

export const FirebaseAuthGuardProvider = {
  provide: APP_GUARD,
  useClass: FirebaseAuthGuard,
};
