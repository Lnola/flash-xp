import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { Mediator } from 'shared/mediator';
import { BaseEvent } from '.';

@Injectable()
export abstract class BaseEventHandler<T extends BaseEvent<unknown>>
  implements OnModuleInit, OnModuleDestroy
{
  protected abstract handle(event: T): void;
  private unsubscribe?: () => void;

  constructor(
    private readonly mediator: Mediator,
    private readonly eventName: string,
  ) {}

  onModuleInit() {
    const handler = (event: T) => this.handle(event);
    this.unsubscribe = this.mediator.subscribe(this.eventName, handler);
  }

  onModuleDestroy() {
    this.unsubscribe?.();
  }
}
