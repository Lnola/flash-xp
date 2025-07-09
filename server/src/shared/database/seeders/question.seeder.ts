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

  // Deck 3 – Human Anatomy: Skeletal System (Self-assessment, open-ended)
  {
    text: 'Describe the number and role of cervical vertebrae in the human spine.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the anatomical name, location, and function of the collarbone.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss the largest bone in the human body and its importance.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the bone that forms the human forehead and its structural significance.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Identify the bones of the lower arm and explain their roles.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss the classification and function of the patella in the skeletal system.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain how many bones are found in the adult human body and describe their general organization.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the structure and protective role of the rib cage.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain which bone connects the arm to the body and describe its function.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Identify the longest bone in the human body and discuss its function.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the axial skeleton and its components.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain which bones protect the brain and their arrangement.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the type of joint found in the shoulder and discuss its range of motion.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the function of cartilage in the skeletal system and provide examples.',
    deckIndex: 3,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss the bone that forms the lower jaw and its role in facial structure.',
    deckIndex: 3,
    questionTypeIndex: 1,
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

  // Deck 5 – Photosynthesis Process (Self-assessment, open-ended)
  {
    text: 'Describe the organelle where photosynthesis occurs and explain its role in the cell.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain how plants absorb gases during photosynthesis and identify which gas is taken in.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss the pigment that absorbs light energy for photosynthesis and describe its importance.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the two main stages of photosynthesis and summarize what occurs in each stage.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Write and explain the balanced chemical equation for photosynthesis, including the significance of each component.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Identify the molecule produced during photosynthesis that serves as an energy source for plants and explain its role.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the function of chlorophyll in photosynthesis and discuss how it contributes to the process.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss which parts of the light spectrum are most effective for photosynthesis and explain why.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the process of photolysis during photosynthesis and explain its importance.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain where the Calvin cycle takes place within the plant cell and describe its main function.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Identify the main product of the Calvin cycle and discuss its significance for the plant.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the role of stomata in photosynthesis and explain how they regulate gas exchange.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the origin of oxygen released during photosynthesis and describe the step in which it is produced.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Name and compare the two main types of chlorophyll found in plants and discuss their roles.',
    deckIndex: 5,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss the effect of temperature on the rate of photosynthesis and explain the underlying reasons.',
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
    text: 'Factor the expression x² - 9.',
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
    text: 'What are the names of the two feuding families in "Romeo and Juliet"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Who is the Moorish general in the Shakespeare play "Othello"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'In which Shakespeare play do the characters Goneril, Regan, and Cordelia appear?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Where is the setting of "The Tempest"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },
  {
    text: 'Who murders King Duncan in "Macbeth"?',
    deckIndex: 8,
    questionTypeIndex: 0,
  },

  // Deck 9 – Cybersecurity Fundamentals
  {
    text: 'Explain what a VPN is and how it enhances online security.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Define phishing and describe common techniques used in such attacks.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe the purpose and function of a firewall in cybersecurity.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the security principle represented by the acronym CIA and its components.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Discuss what ransomware is and how it affects computer systems.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe how HTTPS secures HTTP traffic and why it is important.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the concept of two-factor authentication and its benefits.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Define a brute force attack and discuss methods to prevent it.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'What is a DDoS attack? Describe its impact on network services.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the role of encryption in protecting data within cybersecurity.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe what HTTPS stands for and its importance in web security.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain the primary function of a firewall in network security.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Identify common methods hackers use to gain unauthorized access and how to defend against them.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Describe social engineering in cybersecurity and provide examples of such attacks.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
  {
    text: 'Explain how a VPN enhances security and privacy for users.',
    deckIndex: 9,
    questionTypeIndex: 1,
  },
];
