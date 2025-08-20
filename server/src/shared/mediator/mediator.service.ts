import { EventEmitter } from 'events';
import { Injectable, OnModuleDestroy } from '@nestjs/common';
import { BaseEvent } from 'shared/events';

export type EventHandler<T> = (event: BaseEvent<T>) => void;

@Injectable()
export class Mediator implements OnModuleDestroy {
  private readonly bus = new EventEmitter();

  publish<T>(event: BaseEvent<T>): void {
    this.bus.emit(event.name, event);
  }

  subscribe<T>(name: string, handler: EventHandler<T>): () => void {
    this.bus.on(name, handler);
    return () => this.bus.off(name, handler);
  }

  onModuleDestroy() {
    this.bus.removeAllListeners();
  }
}
