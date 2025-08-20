export interface IntegrationEvent<T = unknown> {
  id: string;
  type: string;
  payload: T;
  occurredAt: Date;
}
