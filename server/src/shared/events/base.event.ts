export abstract class BaseEvent<T> {
  createdAt: Date = new Date();

  constructor(public payload: T) {}

  static get name() {
    return this.constructor.name;
  }

  get name() {
    return this.constructor.name;
  }
}
