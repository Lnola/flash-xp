import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

@Entity({ tableName: 'user' })
export class User extends BaseEntity {
  @Property()
  ssoId!: string;

  constructor({ ssoId }: CreateUserProps) {
    super();
    this.ssoId = ssoId;
  }
}

type CreateUserProps = {
  ssoId: string;
};
