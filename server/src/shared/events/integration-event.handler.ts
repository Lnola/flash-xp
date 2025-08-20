import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { Mediator } from 'shared/mediator';
import { IntegrationEvent } from './integration.event';

@Injectable()
export abstract class IntegrationEventHandler<
    T extends IntegrationEvent<unknown>,
  >
  implements OnModuleInit, OnModuleDestroy
{
  protected abstract readonly eventName: string;
  protected abstract handle(event: T): void;
  private unsubscribe?: () => void;

  constructor(private readonly mediator: Mediator) {}

  onModuleInit() {
    const handler = (event: T) => this.handle(event);
    this.unsubscribe = this.mediator.subscribe(this.eventName, handler);
  }

  onModuleDestroy() {
    this.unsubscribe?.();
  }
}
