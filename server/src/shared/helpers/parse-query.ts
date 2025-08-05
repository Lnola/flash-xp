import { ObjectQuery } from '@mikro-orm/core';

type ParseQueryPagination = {
  limit?: number;
  offset?: number;
};
type ParseQueryWhere<K> = ObjectQuery<K>;

type ParseQueryParams<T> = T & ParseQueryPagination;
export type ParseQueryHandlers<T, K> = Record<
  string,
  (where: ParseQueryWhere<K>, filters: T) => void
>;

export function parseQuery<T, K>(
  { limit, offset, ...filters }: ParseQueryParams<T>,
  handlers: ParseQueryHandlers<T, K>,
) {
  const where: ParseQueryWhere<K> = {};
  for (const key in filters) {
    if (handlers[key]) {
      handlers[key](where, filters as T);
    }
  }
  return { where, pagination: { limit, offset } };
}
