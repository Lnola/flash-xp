import { Entity, Property } from '@mikro-orm/core';
import BaseEntity from 'shared/database/base.entity';

type CreateUserProps = {
  ssoId: string;
};

@Entity({ tableName: 'user' })
export class User extends BaseEntity {
  @Property()
  ssoId!: string;

  constructor({ ssoId }: CreateUserProps) {
    super();
    this.ssoId = ssoId;
  }
}
