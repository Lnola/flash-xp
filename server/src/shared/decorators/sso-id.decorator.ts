import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';

export const SsoId = createParamDecorator(
  (_: string, context: ExecutionContext) => {
    const request = context.switchToHttp().getRequest<Request>();
    const ssoId = request.ssoId;
    return ssoId;
  },
);
