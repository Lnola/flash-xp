import z from 'zod';
import { createDeckSchema } from 'authoring/api/validators';

export type CreateDeckDto = z.infer<typeof createDeckSchema>;
