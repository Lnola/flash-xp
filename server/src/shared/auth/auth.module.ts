import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { User } from 'shared/auth/entities';
import { FirebaseAuthGuard, FirebaseAuthGuardProvider } from 'shared/guards';

@Module({
  imports: [MikroOrmModule.forFeature([User])],
  providers: [FirebaseAuthGuard, FirebaseAuthGuardProvider],
  exports: [FirebaseAuthGuard],
})
export class AuthModule {}
