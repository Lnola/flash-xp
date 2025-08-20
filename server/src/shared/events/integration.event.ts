export abstract class IntegrationEvent<T> {
  createdAt: Date = new Date();

  constructor(public payload: T) {}

  static get name() {
    return this.constructor.name;
  }
}
