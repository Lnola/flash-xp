type ParseQueryPagination = {
  limit?: number;
  offset?: number;
};
type ParseQueryWhere = Record<string, unknown>;

type ParseQueryParams<T> = T & ParseQueryPagination;
export type ParseQueryHandlers<T> = Record<
  string,
  (where: ParseQueryWhere, filters: T) => void
>;

export function parseQuery<T>(
  { limit, offset, ...filters }: ParseQueryParams<T>,
  handlers: ParseQueryHandlers<T>,
) {
  const where: ParseQueryWhere = {};
  for (const key in filters) {
    if (handlers[key]) {
      handlers[key](where, filters as T);
    }
  }
  return { where, pagination: { limit, offset } };
}
