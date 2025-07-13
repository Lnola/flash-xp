import { APP_GUARD } from '@nestjs/core';
import { FirebaseAuthGuard } from 'shared/auth/guards';

export const FirebaseAuthGuardProvider = {
  provide: APP_GUARD,
  useClass: FirebaseAuthGuard,
};
