import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Injectable } from '@nestjs/common';
import { CatalogDeck } from 'catalog/core/entities';

@Injectable()
export class CatalogDeckService {
  constructor(
    @InjectRepository(CatalogDeck)
    private readonly catalogDeckRepository: EntityRepository<CatalogDeck>,
  ) {}

  fetchAll() {
    return this.catalogDeckRepository.findAll();
  }

  fetchById(id: number) {
    // TODO: add error handling
    return this.catalogDeckRepository.findOne(id, { populate: ['questions'] });
  }
}
