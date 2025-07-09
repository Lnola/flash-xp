import type { EntityManager } from '@mikro-orm/core';
import { Seeder } from '@mikro-orm/seeder';
import { Question } from 'authoring/core/entities';
import { DatabaseSeederContext } from '.';

export class QuestionSeeder extends Seeder {
  async run(em: EntityManager, context: DatabaseSeederContext): Promise<void> {
    const seedQuestions = questions.map((it) => {
      return new Question({
        ...it,
        deck: context.decks[it.deckIndex],
        questionType: context.questionTypes[it.questionTypeIndex],
      });
    });
    context.questions = seedQuestions;
    return em.persistAndFlush(seedQuestions);
  }
}

const questions = [
  // Deck 0 – Basic Spanish Phrases
  {
    text: 'How do you say "Good morning" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'Translate to Spanish: "I would like a coffee, please".',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you ask "Where is the bathroom?" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What does "Gracias" mean in English?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you say "My name is..." in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you say "Good night" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'Translate to Spanish: "See you later".',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the Spanish word for "please"?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you say "Thank you very much" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'Translate to Spanish: "I don`t understand".',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you ask "How are you?" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What does "Por favor" mean in English?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you say "Excuse me" in Spanish?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'Translate to Spanish: "I am learning Spanish".',
    deckIndex: 0,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the Spanish word for "friend"?',
    deckIndex: 0,
    questionTypeIndex: 0,
  },

  // Deck 1 – World War II Overview
  {
    text: 'In which year did World War II begin?',
    deckIndex: 1,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the Allied powers known as the "Big Three".',
    deckIndex: 1,
    questionTypeIndex: 1,
  },
  {
    text: 'What event brought the United States into World War II?',
    deckIndex: 1,
    questionTypeIndex: 0,
  },
  {
    text: 'Which city was the first to be hit by an atomic bomb?',
    deckIndex: 1,
    questionTypeIndex: 0,
  },
  {
    text: 'What was the codename for the Allied invasion of Normandy?',
    deckIndex: 1,
    questionTypeIndex: 0,
  },
  {
    text: 'Who was the British Prime Minister during most of World War II?',
    deckIndex: 1,
    questionTypeIndex: 0,
  },

  // Deck 2 – Introduction to JavaScript
  {
    text: 'What keyword declares a constant variable in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Which built-in method converts a JSON string into an object?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What does "NaN" stand for in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Which array method creates a new array by calling a function on every element?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Explain the difference between "==" and "===" in JavaScript.',
    deckIndex: 2,
    questionTypeIndex: 1,
  },
  {
    text: 'How do you declare a function in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the purpose of the "this" keyword?',
    deckIndex: 2,
    questionTypeIndex: 1,
  },
  {
    text: 'Which method adds an element to the end of an array?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What does the "typeof" operator do?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Explain what a promise is in JavaScript.',
    deckIndex: 2,
    questionTypeIndex: 1,
  },
  {
    text: 'What is the difference between var, let, and const?',
    deckIndex: 2,
    questionTypeIndex: 1,
  },
  {
    text: 'How do you write a comment in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is an arrow function?',
    deckIndex: 2,
    questionTypeIndex: 1,
  },
  {
    text: 'Which method removes the last element from an array?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is event bubbling in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 1,
  },

  // Deck 3 – Human Anatomy: Skeletal System
  {
    text: 'How many cervical vertebrae does the human spine contain?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'Which bone is commonly referred to as the collarbone?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the largest bone in the human body?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the bone that forms the human forehead.',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'Which bones make up the lower arm?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'What type of bone is the patella classified as?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'How many bones are in the adult human body?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the function of the rib cage?',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Which bone connects the arm to the body?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the longest bone in the human body.',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the axial skeleton?',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Which bones protect the brain?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },
  {
    text: 'What type of joint is found in the shoulder?',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'What is the function of cartilage in the skeletal system?',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Which bone forms the lower jaw?',
    deckIndex: 3,
    questionTypeIndex: 0,
  },

  // Deck 4 – European Capitals
  {
    text: 'What is the capital of Italy?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Croatia?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Norway?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Portugal?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Hungary?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the capital of Poland?',
    deckIndex: 4,
    questionTypeIndex: 0,
  },

  // Deck 5 – Photosynthesis Process
  {
    text: 'In which organelle does photosynthesis take place?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'What gas is absorbed by plants during photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the pigment responsible for absorbing light energy.',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'What are the two main stages of photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Write the balanced chemical equation for photosynthesis.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Which molecule produced in photosynthesis is a source of energy for plants?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the role of chlorophyll in photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Which light spectrum is most effective for photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'What is photolysis in photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Where does the Calvin cycle take place?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the main product of the Calvin cycle?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'How do stomata contribute to photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'What is the source of oxygen released during photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the two types of chlorophyll found in plants.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'How does temperature affect photosynthesis?',
    deckIndex: 5,
    questionTypeIndex: 1,
  },

  // Deck 6 – US Presidents
  {
    text: 'Who was the first President of the United States?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },
  {
    text: 'Which U.S. President issued the Emancipation Proclamation?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },
  {
    text: 'Who was President during the Great Depression and most of World War II?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },
  {
    text: 'Who is the only U.S. President to serve more than two terms?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },
  {
    text: 'Who was the 45th President of the United States?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },
  {
    text: 'Which President resigned from office in 1974?',
    deckIndex: 6,
    questionTypeIndex: 0,
  },

  // Deck 7 – Mathematics: Algebra Basics
  {
    text: 'Solve for x: 2x + 3 = 11.',
    deckIndex: 7,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the quadratic formula?',
    deckIndex: 7,
    questionTypeIndex: 1,
  },
  {
    text: 'Factor the expression x² − 9.',
    deckIndex: 7,
    questionTypeIndex: 0,
  },
  {
    text: 'Simplify the product (3x²)(2x³).',
    deckIndex: 7,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the slope-intercept form of a linear equation?',
    deckIndex: 7,
    questionTypeIndex: 0,
  },
  {
    text: 'Define a polynomial.',
    deckIndex: 7,
    questionTypeIndex: 1,
  },

  // Deck 8 – Shakespearean Plays
  {
    text: 'Which play features the line "To be, or not to be"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the two feuding families in "Romeo and Juliet".',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Who is the Moorish general in Venice in a Shakespeare tragedy?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Which Shakespeare play includes the characters Goneril, Regan, and Cordelia?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the setting of "The Tempest"?',
    deckIndex: 8,
    questionTypeIndex: 1,
  },
  {
    text: 'Who murders King Duncan in "Macbeth"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },

  // Deck 9 – Cybersecurity Fundamentals
  {
    text: 'What does the acronym VPN stand for?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'Define phishing.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'What is the purpose of a firewall?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'Name the security principle represented by the acronym CIA.',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'What type of malware demands payment to unlock data?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'Which protocol secures HTTP traffic with encryption?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'What is two-factor authentication?',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Define a brute force attack.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'What is a DDoS attack?',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the role of encryption in cybersecurity.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'What does the acronym HTTPS stand for?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'What is a firewall`s primary function?',
    deckIndex: 9,
    questionTypeIndex: 0,
  },
  {
    text: 'Name a common method hackers use to gain unauthorized access.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'What is social engineering in cybersecurity?',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'How does a VPN enhance security?',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
];
