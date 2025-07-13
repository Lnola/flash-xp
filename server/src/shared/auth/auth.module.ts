import { MikroOrmModule } from '@mikro-orm/nestjs';
import { Module } from '@nestjs/common';
import { User } from './entities';
import { FirebaseAuthGuard } from './guards';
import { FirebaseAuthGuardProvider } from './providers';

@Module({
  imports: [MikroOrmModule.forFeature([User])],
  providers: [FirebaseAuthGuard, FirebaseAuthGuardProvider],
  exports: [FirebaseAuthGuard],
})
export class AuthModule {}
