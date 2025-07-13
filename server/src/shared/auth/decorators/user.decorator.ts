import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';
import { User as UserEntity } from 'shared/entities';

export const User = createParamDecorator(
  (field: keyof UserEntity, context: ExecutionContext) => {
    const request = context.switchToHttp().getRequest<Request>();
    const user = request.user;
    return field ? user[field] : user;
  },
);
