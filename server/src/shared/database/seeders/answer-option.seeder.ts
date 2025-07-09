import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { AnswerOption } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

export class AnswerOptionSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedAnswerOptions = answerOptions.map((it) => {
      return new AnswerOption({
        ...it,
        question: context.questions[it.questionIndex],
      });
    });
    return em.persistAndFlush(seedAnswerOptions);
  }
}

const answerOptions = [
  // Deck 0 – Basic Spanish Phrases

  { text: 'Buenas noches', isCorrect: false, questionIndex: 0 },
  { text: 'Buenos días', isCorrect: true, questionIndex: 0 },
  { text: 'Hola', isCorrect: false, questionIndex: 0 },
  { text: 'Gracias', isCorrect: false, questionIndex: 0 },

  { text: 'Yo tengo café, gracias', isCorrect: false, questionIndex: 1 },
  { text: 'Dónde está el café', isCorrect: false, questionIndex: 1 },
  { text: 'Quisiera un café, por favor', isCorrect: true, questionIndex: 1 },
  { text: 'Café es bueno', isCorrect: false, questionIndex: 1 },

  { text: '¿Cómo estás?', isCorrect: false, questionIndex: 2 },
  { text: '¿Qué hora es?', isCorrect: false, questionIndex: 2 },
  { text: '¿Dónde está el baño?', isCorrect: true, questionIndex: 2 },
  { text: '¿Dónde vives?', isCorrect: false, questionIndex: 2 },

  { text: 'Goodbye', isCorrect: false, questionIndex: 3 },
  { text: 'Please', isCorrect: false, questionIndex: 3 },
  { text: 'Hello', isCorrect: false, questionIndex: 3 },
  { text: 'Thank you', isCorrect: true, questionIndex: 3 },

  { text: 'Me llamo...', isCorrect: true, questionIndex: 4 },
  { text: 'Soy de...', isCorrect: false, questionIndex: 4 },
  { text: 'Hola amigo', isCorrect: false, questionIndex: 4 },
  { text: 'Tengo años', isCorrect: false, questionIndex: 4 },

  { text: 'Buenos días', isCorrect: false, questionIndex: 5 },
  { text: 'Buenas noches', isCorrect: true, questionIndex: 5 },
  { text: 'Buenas tardes', isCorrect: false, questionIndex: 5 },
  { text: 'Hasta luego', isCorrect: false, questionIndex: 5 },

  { text: 'Buenos días', isCorrect: false, questionIndex: 6 },
  { text: 'Cómo estás', isCorrect: false, questionIndex: 6 },
  { text: 'Hasta luego', isCorrect: true, questionIndex: 6 },
  { text: 'Buenas noches', isCorrect: false, questionIndex: 6 },

  { text: 'Por favor', isCorrect: true, questionIndex: 7 },
  { text: 'Gracias', isCorrect: false, questionIndex: 7 },
  { text: 'Hola', isCorrect: false, questionIndex: 7 },
  { text: 'Adiós', isCorrect: false, questionIndex: 7 },

  { text: 'Buenos días', isCorrect: false, questionIndex: 8 },
  { text: 'Muchas gracias', isCorrect: true, questionIndex: 8 },
  { text: 'Buenas tardes', isCorrect: false, questionIndex: 8 },
  { text: 'Hasta pronto', isCorrect: false, questionIndex: 8 },

  { text: 'No hablo inglés', isCorrect: false, questionIndex: 9 },
  { text: 'No entiendo', isCorrect: true, questionIndex: 9 },
  { text: 'No sé', isCorrect: false, questionIndex: 9 },
  { text: 'Estoy bien', isCorrect: false, questionIndex: 9 },

  { text: '¿Dónde vives?', isCorrect: false, questionIndex: 10 },
  { text: '¿Qué hora es?', isCorrect: false, questionIndex: 10 },
  { text: '¿Cómo estás?', isCorrect: true, questionIndex: 10 },
  { text: '¿Quién eres?', isCorrect: false, questionIndex: 10 },

  { text: 'Please', isCorrect: true, questionIndex: 11 },
  { text: 'Thank you', isCorrect: false, questionIndex: 11 },
  { text: 'Sorry', isCorrect: false, questionIndex: 11 },
  { text: 'Hello', isCorrect: false, questionIndex: 11 },

  { text: 'Gracias', isCorrect: false, questionIndex: 12 },
  { text: 'Hola', isCorrect: false, questionIndex: 12 },
  { text: 'Adiós', isCorrect: false, questionIndex: 12 },
  { text: 'Perdón', isCorrect: true, questionIndex: 12 },

  { text: 'No hablo español', isCorrect: false, questionIndex: 13 },
  { text: 'Puedo ir al baño', isCorrect: false, questionIndex: 13 },
  { text: 'Tengo hambre', isCorrect: false, questionIndex: 13 },
  { text: 'Estoy aprendiendo español', isCorrect: true, questionIndex: 13 },

  { text: 'Padre', isCorrect: false, questionIndex: 14 },
  { text: 'Amigo', isCorrect: true, questionIndex: 14 },
  { text: 'Libro', isCorrect: false, questionIndex: 14 },
  { text: 'Mesa', isCorrect: false, questionIndex: 14 },

  // Deck 1 – World War II Overview
  { text: '1914', isCorrect: false, questionIndex: 15 },
  { text: '1941', isCorrect: false, questionIndex: 15 },
  { text: '1939', isCorrect: true, questionIndex: 15 },
  { text: '1945', isCorrect: false, questionIndex: 15 },

  // questionIndex: 16
  {
    text: 'United States, United Kingdom, Soviet Union',
    isCorrect: true,
    questionIndex: 16,
  },
  { text: 'Germany, Italy, Japan', isCorrect: false, questionIndex: 16 },
  {
    text: 'France, China, United Kingdom',
    isCorrect: false,
    questionIndex: 16,
  },
  {
    text: 'United States, France, Germany',
    isCorrect: false,
    questionIndex: 16,
  },

  { text: 'Sinking of the Lusitania', isCorrect: false, questionIndex: 17 },
  { text: 'Fall of France', isCorrect: false, questionIndex: 17 },
  { text: 'Attack on Pearl Harbor', isCorrect: true, questionIndex: 17 },
  { text: 'Invasion of Poland', isCorrect: false, questionIndex: 17 },

  { text: 'Nagasaki', isCorrect: false, questionIndex: 18 },
  { text: 'Hiroshima', isCorrect: true, questionIndex: 18 },
  { text: 'Tokyo', isCorrect: false, questionIndex: 18 },
  { text: 'Kyoto', isCorrect: false, questionIndex: 18 },

  { text: 'Operation Overlord', isCorrect: true, questionIndex: 19 },
  { text: 'Operation Desert Storm', isCorrect: false, questionIndex: 19 },
  { text: 'Operation Torch', isCorrect: false, questionIndex: 19 },
  { text: 'Operation Neptune', isCorrect: false, questionIndex: 19 },

  { text: 'Winston Churchill', isCorrect: true, questionIndex: 20 },
  { text: 'Neville Chamberlain', isCorrect: false, questionIndex: 20 },
  { text: 'Clement Attlee', isCorrect: false, questionIndex: 20 },
  { text: 'Franklin D. Roosevelt', isCorrect: false, questionIndex: 20 },

  // Deck 2 – Introduction to JavaScript
  // questionIndex 21
  { text: 'let', isCorrect: false, questionIndex: 21 },
  { text: 'var', isCorrect: false, questionIndex: 21 },
  { text: 'static', isCorrect: false, questionIndex: 21 },
  { text: 'const', isCorrect: true, questionIndex: 21 },

  // questionIndex 22
  { text: 'JSON.stringify()', isCorrect: false, questionIndex: 22 },
  { text: 'JSON.parse()', isCorrect: true, questionIndex: 22 },
  { text: 'JSON.toObject()', isCorrect: false, questionIndex: 22 },
  { text: 'parseJSON()', isCorrect: false, questionIndex: 22 },

  // questionIndex 23
  { text: 'Not a Number', isCorrect: true, questionIndex: 23 },
  { text: 'Negative a Number', isCorrect: false, questionIndex: 23 },
  { text: 'Not an Integer', isCorrect: false, questionIndex: 23 },
  { text: 'Not a Name', isCorrect: false, questionIndex: 23 },

  // questionIndex 24
  { text: 'forEach()', isCorrect: false, questionIndex: 24 },
  { text: 'map()', isCorrect: true, questionIndex: 24 },
  { text: 'filter()', isCorrect: false, questionIndex: 24 },
  { text: 'reduce()', isCorrect: false, questionIndex: 24 },

  // questionIndex 26
  { text: 'func myFunc() {}', isCorrect: false, questionIndex: 26 },
  { text: 'def myFunc() {}', isCorrect: false, questionIndex: 26 },
  { text: 'function myFunc() {}', isCorrect: true, questionIndex: 26 },
  { text: 'method myFunc() {}', isCorrect: false, questionIndex: 26 },

  // questionIndex 28
  { text: 'pop()', isCorrect: false, questionIndex: 28 },
  { text: 'shift()', isCorrect: false, questionIndex: 28 },
  { text: 'push()', isCorrect: true, questionIndex: 28 },
  { text: 'unshift()', isCorrect: false, questionIndex: 28 },

  // questionIndex 29
  {
    text: 'Returns the data type of a value',
    isCorrect: true,
    questionIndex: 29,
  },
  { text: 'Converts value to string', isCorrect: false, questionIndex: 29 },
  { text: 'Checks value equality', isCorrect: false, questionIndex: 29 },
  { text: 'Declares a new variable', isCorrect: false, questionIndex: 29 },

  // questionIndex 32
  { text: '/* multi-line comment */', isCorrect: false, questionIndex: 32 },
  { text: '# comment', isCorrect: false, questionIndex: 32 },
  { text: '<!-- comment -->', isCorrect: false, questionIndex: 32 },
  { text: '// single-line comment', isCorrect: true, questionIndex: 32 },

  // questionIndex 34
  { text: 'pop()', isCorrect: true, questionIndex: 34 },
  { text: 'shift()', isCorrect: false, questionIndex: 34 },
  { text: 'slice()', isCorrect: false, questionIndex: 34 },
  { text: 'splice()', isCorrect: false, questionIndex: 34 },

  // Deck 4 – European Capitals
  { text: 'Milan', isCorrect: false, questionIndex: 50 },
  { text: 'Venice', isCorrect: false, questionIndex: 50 },
  { text: 'Florence', isCorrect: false, questionIndex: 50 },
  { text: 'Rome', isCorrect: true, questionIndex: 50 },

  { text: 'Split', isCorrect: false, questionIndex: 51 },
  { text: 'Zagreb', isCorrect: true, questionIndex: 51 },
  { text: 'Dubrovnik', isCorrect: false, questionIndex: 51 },
  { text: 'Rijeka', isCorrect: false, questionIndex: 51 },

  { text: 'Bergen', isCorrect: false, questionIndex: 52 },
  { text: 'Stockholm', isCorrect: false, questionIndex: 52 },
  { text: 'Oslo', isCorrect: true, questionIndex: 52 },
  { text: 'Copenhagen', isCorrect: false, questionIndex: 52 },

  { text: 'Porto', isCorrect: false, questionIndex: 53 },
  { text: 'Lisbon', isCorrect: true, questionIndex: 53 },
  { text: 'Madrid', isCorrect: false, questionIndex: 53 },
  { text: 'Seville', isCorrect: false, questionIndex: 53 },

  { text: 'Budapest', isCorrect: true, questionIndex: 54 },
  { text: 'Debrecen', isCorrect: false, questionIndex: 54 },
  { text: 'Szeged', isCorrect: false, questionIndex: 54 },
  { text: 'Bratislava', isCorrect: false, questionIndex: 54 },

  { text: 'Kraków', isCorrect: false, questionIndex: 55 },
  { text: 'Gdańsk', isCorrect: false, questionIndex: 55 },
  { text: 'Wrocław', isCorrect: false, questionIndex: 55 },
  { text: 'Warsaw', isCorrect: true, questionIndex: 55 },

  // Deck 6 – US Presidents
  { text: 'Thomas Jefferson', isCorrect: false, questionIndex: 71 },
  { text: 'George Washington', isCorrect: true, questionIndex: 71 },
  { text: 'Abraham Lincoln', isCorrect: false, questionIndex: 71 },
  { text: 'John Adams', isCorrect: false, questionIndex: 71 },

  { text: 'Ulysses S. Grant', isCorrect: false, questionIndex: 72 },
  { text: 'Andrew Johnson', isCorrect: false, questionIndex: 72 },
  { text: 'Abraham Lincoln', isCorrect: true, questionIndex: 72 },
  { text: 'James Buchanan', isCorrect: false, questionIndex: 72 },

  { text: 'Herbert Hoover', isCorrect: false, questionIndex: 73 },
  { text: 'Harry S. Truman', isCorrect: false, questionIndex: 73 },
  { text: 'Woodrow Wilson', isCorrect: false, questionIndex: 73 },
  { text: 'Franklin D. Roosevelt', isCorrect: true, questionIndex: 73 },

  { text: 'George Washington', isCorrect: false, questionIndex: 74 },
  { text: 'Franklin D. Roosevelt', isCorrect: true, questionIndex: 74 },
  { text: 'Theodore Roosevelt', isCorrect: false, questionIndex: 74 },
  { text: 'Barack Obama', isCorrect: false, questionIndex: 74 },

  { text: 'Joe Biden', isCorrect: false, questionIndex: 75 },
  { text: 'Donald Trump', isCorrect: true, questionIndex: 75 },
  { text: 'Barack Obama', isCorrect: false, questionIndex: 75 },
  { text: 'George W. Bush', isCorrect: false, questionIndex: 75 },

  { text: 'Gerald Ford', isCorrect: false, questionIndex: 76 },
  { text: 'Jimmy Carter', isCorrect: false, questionIndex: 76 },
  { text: 'Lyndon B. Johnson', isCorrect: false, questionIndex: 76 },
  { text: 'Richard Nixon', isCorrect: true, questionIndex: 76 },

  // Deck 7 – Mathematics: Algebra Basics
  // questionIndex 77
  { text: '3', isCorrect: false, questionIndex: 77 },
  { text: '4', isCorrect: true, questionIndex: 77 },
  { text: '5', isCorrect: false, questionIndex: 77 },
  { text: '6', isCorrect: false, questionIndex: 77 },

  // questionIndex 79
  { text: '(x − 3)(x + 3)', isCorrect: true, questionIndex: 79 },
  { text: '(x − 9)(x + 9)', isCorrect: false, questionIndex: 79 },
  { text: 'x(x − 9)', isCorrect: false, questionIndex: 79 },
  { text: '(x − 2)(x + 2)', isCorrect: false, questionIndex: 79 },

  // questionIndex 80
  { text: '6x⁶', isCorrect: false, questionIndex: 80 },
  { text: '6x⁵', isCorrect: true, questionIndex: 80 },
  { text: '5x⁵', isCorrect: false, questionIndex: 80 },
  { text: '6x³', isCorrect: false, questionIndex: 80 },

  // questionIndex 81
  { text: 'x = my + b', isCorrect: false, questionIndex: 81 },
  { text: 'y = b + xᵐ', isCorrect: false, questionIndex: 81 },
  { text: 'y = m/x + b', isCorrect: false, questionIndex: 81 },
  { text: 'y = mx + b', isCorrect: true, questionIndex: 81 },

  // Deck 8 – Shakespearean Plays
  { text: 'Macbeth', isCorrect: false, questionIndex: 83 },
  { text: 'Hamlet', isCorrect: true, questionIndex: 83 },
  { text: 'Othello', isCorrect: false, questionIndex: 83 },
  { text: 'King Lear', isCorrect: false, questionIndex: 83 },

  { text: 'Lancaster and York', isCorrect: false, questionIndex: 84 },
  { text: 'Macbeth and Banquo', isCorrect: false, questionIndex: 84 },
  { text: 'Montague and Capulet', isCorrect: true, questionIndex: 84 },
  { text: 'Tudor and Stuart', isCorrect: false, questionIndex: 84 },

  { text: 'Macbeth', isCorrect: false, questionIndex: 85 },
  { text: 'Hamlet', isCorrect: false, questionIndex: 85 },
  { text: 'Othello', isCorrect: true, questionIndex: 85 },
  { text: 'Julius Caesar', isCorrect: false, questionIndex: 85 },

  { text: 'The Tempest', isCorrect: false, questionIndex: 86 },
  { text: 'King Lear', isCorrect: true, questionIndex: 86 },
  { text: 'Twelfth Night', isCorrect: false, questionIndex: 86 },
  { text: 'Othello', isCorrect: false, questionIndex: 86 },

  // questionIndex 87 – open-ended, skipped

  { text: 'Macbeth', isCorrect: true, questionIndex: 88 },
  { text: 'Banquo', isCorrect: false, questionIndex: 88 },
  { text: 'Duncan himself', isCorrect: false, questionIndex: 88 },
  { text: 'Macduff', isCorrect: false, questionIndex: 88 },
];
