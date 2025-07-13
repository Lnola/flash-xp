import { Module } from '@nestjs/common';
import { DeckController } from './api';
import { DeckService } from './core/services';

@Module({
  providers: [DeckService],
  controllers: [DeckController],
})
export class AuthoringModule {}
