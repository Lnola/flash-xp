type ParseQueryFilters = Record<string, unknown>;
type ParseQueryPagination = {
  limit?: number;
  offset?: number;
};
type ParseQueryWhere = Record<string, unknown>;

type ParseQueryParams = ParseQueryFilters & ParseQueryPagination;
export type ParseQueryHandlers = Record<
  string,
  (where: ParseQueryWhere, filters: ParseQueryFilters) => void
>;

export const parseQuery = (
  { limit, offset, ...filters }: ParseQueryParams,
  handlers: ParseQueryHandlers,
) => {
  const where: ParseQueryWhere = {};
  for (const key in filters) {
    if (handlers[key]) {
      handlers[key](where, filters);
    }
  }
  return { where, pagination: { limit, offset } };
};
