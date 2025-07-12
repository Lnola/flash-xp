import {
  EntityManager,
  EntityRepository,
  AnyEntity,
} from '@mikro-orm/postgresql';

export class BaseEntityRepository<
  T extends object,
> extends EntityRepository<T> {
  async flush(): Promise<void> {
    return this.em.flush();
  }

  persist(entity: AnyEntity | AnyEntity[]): EntityManager {
    return this.em.persist(entity);
  }

  async persistAndFlush(entity: AnyEntity | AnyEntity[]): Promise<void> {
    await this.em.persistAndFlush(entity);
  }

  remove(entity: AnyEntity): EntityManager {
    return this.em.remove(entity);
  }

  async removeAndFlush(entity: AnyEntity): Promise<void> {
    await this.em.removeAndFlush(entity);
  }
}
