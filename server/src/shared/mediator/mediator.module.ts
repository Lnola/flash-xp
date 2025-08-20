import { Global, Module } from '@nestjs/common';
import { Mediator } from './mediator.service';

@Global()
@Module({
  providers: [Mediator],
  exports: [Mediator],
})
export class MediatorModule {}
