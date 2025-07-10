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
    questionTypeIndex: 0,
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
    text: 'What is the main difference between "==" and "===" in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you declare a function in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What does the "this" keyword refer to in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
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
    text: 'What is a promise in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Which is true about var, let, and const?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'How do you write a comment in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What is the main use of the arrow (=>) function in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'Which method removes the last element from an array?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },
  {
    text: 'What happens during event bubbling in JavaScript?',
    deckIndex: 2,
    questionTypeIndex: 0,
  },

  // Deck 3 – Human Anatomy: Skeletal System (Self-assessment, open-ended)
  {
    text: 'Describe the number and role of cervical vertebrae in the human spine.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The human spine contains 7 cervical vertebrae which support the skull, allow for neck movement, and protect the spinal cord.',
  },
  {
    text: 'Explain the anatomical name, location, and function of the collarbone.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The collarbone is anatomically called the clavicle; it is located horizontally between the sternum and scapula, and functions to connect the arm to the trunk and stabilize shoulder movement.',
  },
  {
    text: 'Discuss the largest bone in the human body and its importance.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The femur, or thigh bone, is the largest bone in the human body. It supports the weight of the body, enables locomotion, and forms the hip and knee joints.',
  },
  {
    text: 'Describe the bone that forms the human forehead and its structural significance.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The frontal bone forms the human forehead. It provides structure to the face, protects the frontal lobe of the brain, and forms part of the eye socket.',
  },
  {
    text: 'Identify the bones of the lower arm and explain their roles.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The lower arm consists of the radius and ulna. The radius enables wrist rotation and is on the thumb side, while the ulna stabilizes the forearm and is on the little finger side.',
  },
  {
    text: 'Discuss the classification and function of the patella in the skeletal system.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The patella, or kneecap, is a sesamoid bone embedded in the tendon of the quadriceps. It protects the knee joint and improves the leverage of thigh muscles during extension.',
  },
  {
    text: 'Explain how many bones are found in the adult human body and describe their general organization.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'An adult human typically has 206 bones, organized into the axial skeleton (skull, vertebral column, rib cage) and appendicular skeleton (limbs and girdles).',
  },
  {
    text: 'Describe the structure and protective role of the rib cage.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The rib cage is composed of 12 pairs of ribs, the sternum, and thoracic vertebrae. It encloses and protects vital organs such as the heart and lungs.',
  },
  {
    text: 'Explain which bone connects the arm to the body and describe its function.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The clavicle (collarbone) connects the arm to the body by joining the sternum to the scapula, providing support and facilitating arm movement.',
  },
  {
    text: 'Identify the longest bone in the human body and discuss its function.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The femur is the longest bone in the body. It supports body weight, enables walking and running, and forms the hip and knee joints.',
  },
  {
    text: 'Describe the axial skeleton and its components.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The axial skeleton consists of the skull, vertebral column, and rib cage. It supports the central axis of the body and protects vital organs.',
  },
  {
    text: 'Explain which bones protect the brain and their arrangement.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The brain is protected by the cranial bones—frontal, parietal (2), temporal (2), occipital, sphenoid, and ethmoid—forming the cranium.',
  },
  {
    text: 'Describe the type of joint found in the shoulder and discuss its range of motion.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The shoulder is a ball-and-socket joint, allowing a wide range of motion including rotation, abduction, adduction, flexion, and extension.',
  },
  {
    text: 'Explain the function of cartilage in the skeletal system and provide examples.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'Cartilage provides cushioning, reduces friction in joints, and supports structures. Examples include articular cartilage in joints and the cartilage in the nose and ear.',
  },
  {
    text: 'Discuss the bone that forms the lower jaw and its role in facial structure.',
    deckIndex: 3,
    questionTypeIndex: 1,
    answer:
      'The mandible forms the lower jaw, supports the lower teeth, enables chewing, and shapes the lower face.',
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
    answer:
      'Photosynthesis takes place in chloroplasts, which contain chlorophyll to absorb light and convert it into chemical energy.',
  },
  {
    text: 'Explain how plants absorb gases during photosynthesis and identify which gas is taken in.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Plants absorb carbon dioxide through stomata in their leaves, which is used in the Calvin cycle to produce glucose.',
  },
  {
    text: 'Discuss the pigment that absorbs light energy for photosynthesis and describe its importance.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Chlorophyll is the pigment that absorbs light, primarily blue and red wavelengths, enabling the light reactions of photosynthesis.',
  },
  {
    text: 'Describe the two main stages of photosynthesis and summarize what occurs in each stage.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Photosynthesis has two stages: the light-dependent reactions convert light energy into ATP and NADPH; the Calvin cycle uses those molecules to synthesize glucose.',
  },
  {
    text: 'Write and explain the balanced chemical equation for photosynthesis, including the significance of each component.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      '6CO₂ + 6H₂O + light → C₆H₁₂O₆ + 6O₂; carbon dioxide and water are converted into glucose and oxygen using light energy.',
  },
  {
    text: 'Identify the molecule produced during photosynthesis that serves as an energy source for plants and explain its role.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Glucose is the main product and serves as a vital energy source for plant metabolism and growth.',
  },
  {
    text: 'Explain the function of chlorophyll in photosynthesis and discuss how it contributes to the process.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Chlorophyll captures light energy, which drives the reactions needed to convert CO₂ and H₂O into glucose and O₂.',
  },
  {
    text: 'Discuss which parts of the light spectrum are most effective for photosynthesis and explain why.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Blue and red wavelengths are most effective because chlorophyll absorbs them efficiently, maximizing energy capture.',
  },
  {
    text: 'Describe the process of photolysis during photosynthesis and explain its importance.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Photolysis splits water molecules into oxygen, protons, and electrons during the light-dependent reactions, supplying energy carriers.',
  },
  {
    text: 'Explain where the Calvin cycle takes place within the plant cell and describe its main function.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'The Calvin cycle occurs in the stroma of chloroplasts and uses ATP and NADPH to convert CO₂ into glucose.',
  },
  {
    text: 'Identify the main product of the Calvin cycle and discuss its significance for the plant.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'The Calvin cycle produces glucose, which is essential for plant energy and biomass production.',
  },
  {
    text: 'Describe the role of stomata in photosynthesis and explain how they regulate gas exchange.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Stomata are pores on leaves that regulate gas exchange by opening to allow CO₂ in and releasing O₂ and water vapor.',
  },
  {
    text: 'Explain the origin of oxygen released during photosynthesis and describe the step in which it is produced.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Oxygen is produced during photolysis in the light-dependent reactions when water molecules are split.',
  },
  {
    text: 'Name and compare the two main types of chlorophyll found in plants and discuss their roles.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Chlorophyll a and b are the two types; both absorb light but at slightly different wavelengths to increase energy capture.',
  },
  {
    text: 'Discuss the effect of temperature on the rate of photosynthesis and explain the underlying reasons.',
    deckIndex: 5,
    questionTypeIndex: 1,
    answer:
      'Photosynthesis rate increases with temperature up to an optimum, then declines due to enzyme denaturation and reduced efficiency.',
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
    text: 'Which of these is the correct quadratic formula?',
    deckIndex: 7,
    questionTypeIndex: 0,
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
    text: 'What is the value of 5²?',
    deckIndex: 7,
    questionTypeIndex: 0,
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
    answer:
      'A VPN (Virtual Private Network) encrypts your internet connection and masks your IP, enhancing privacy and security online.',
  },
  {
    text: 'Define phishing and describe common techniques used in such attacks.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Phishing is a type of cyberattack where attackers trick users into revealing sensitive information, often using fake emails or websites.',
  },
  {
    text: 'Describe the purpose and function of a firewall in cybersecurity.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'A firewall monitors and controls incoming and outgoing network traffic to block unauthorized access and protect systems.',
  },
  {
    text: 'Explain the security principle represented by the acronym CIA and its components.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'CIA stands for Confidentiality, Integrity, and Availability—the three core principles of information security.',
  },
  {
    text: 'Discuss what ransomware is and how it affects computer systems.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Ransomware is malicious software that encrypts files and demands payment for their release, disrupting access to data.',
  },
  {
    text: 'Describe how HTTPS secures HTTP traffic and why it is important.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'HTTPS uses encryption (TLS/SSL) to secure data transmitted between a browser and a website, protecting sensitive information.',
  },
  {
    text: 'Explain the concept of two-factor authentication and its benefits.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Two-factor authentication requires users to provide two forms of identification, increasing account security against unauthorized access.',
  },
  {
    text: 'Define a brute force attack and discuss methods to prevent it.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'A brute force attack tries many password combinations to gain access; prevention includes strong passwords and account lockouts.',
  },
  {
    text: 'What is a DDoS attack? Describe its impact on network services.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'A DDoS (Distributed Denial of Service) attack overwhelms a service with traffic, causing slowdowns or outages.',
  },
  {
    text: 'Explain the role of encryption in protecting data within cybersecurity.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Encryption transforms data into unreadable code, ensuring only authorized parties can access the original information.',
  },
  {
    text: 'Describe what HTTPS stands for and its importance in web security.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'HTTPS stands for HyperText Transfer Protocol Secure; it encrypts web traffic, protecting user data from interception.',
  },
  {
    text: 'Explain the primary function of a firewall in network security.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'A firewall acts as a barrier between trusted and untrusted networks, blocking harmful traffic and unauthorized access.',
  },
  {
    text: 'Identify common methods hackers use to gain unauthorized access and how to defend against them.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Hackers use methods like phishing, malware, and exploiting vulnerabilities; defense includes strong passwords and software updates.',
  },
  {
    text: 'Describe social engineering in cybersecurity and provide examples of such attacks.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      'Social engineering manipulates people into revealing information; examples include phishing emails and pretexting phone calls.',
  },
  {
    text: 'Explain how a VPN enhances security and privacy for users.',
    deckIndex: 9,
    questionTypeIndex: 1,
    answer:
      "A VPN encrypts internet traffic and hides the user's IP address, making online activities more private and secure.",
  },
];
