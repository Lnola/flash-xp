import z from 'zod';
import { updateDeckSchema } from 'authoring/api/validators';

export type UpdateDeckDto = z.infer<typeof updateDeckSchema>;
