# flash-xp

## Description

Flash-xp is a flashcard learning platform that implements a spaced repetition learning system, enhanced with gamification elements to make studying more engaging and effective. The platform supports AI-assisted content generation to help users create flashcards effortlessly and includes community features to share and collaborate on learning materials. Available primarily on iOS for now, Android and Web require optimisation.

## Features

- Spaced repetition learning system
- Multiple question types including multiple-choice and self assessment
- AI-generated flashcards to quickly create study materials
- Progress tracking and detailed statistics to monitor learning performance
- Gamification elements to motivate users
- Cross-device synchronization TBD

## Tech Stack

- Flutter for the frontend application
- NestJS for the backend API
- PostgreSQL as the primary database
- Firebase for Authentication and Cloud Functions
- OpenAI API for AI-generated flashcard content

## Installation

Requirements:

- docker
- flutter v3
- node 24 for the server
- node 22 for the cloud functions.

I suggest using `fnm` or `nvm` for running multiple node versions.

1. Clone the repository

   ```bash
   git clone https://github.com/yourusername/flash-xp.git
   cd flash-xp
   ```

1. Install dependencies for client, server and cloud functions

   ```bash
   # Client
   (cd client && flutter pub get)

   # Server
   (cd server && pnpm i)

   # Cloud functions
   (cd functions && pnpm i)
   ```

1. Install the firebase cli tools globally
   ```bash
   pnpm i firebase-tools -g
   ```
1. Setup environment variables
   - Create `.env` files in both server and functions directories with necessary keys and configuration following the `.env.example` povided
1. Run the database a docker container using the provided docker-compose.

   ```bash
   (cd server && docker compose up --d) # add the --d to run the container in detached mode
   ```

1. Init the database by running migrations and seeds.
   ```bash
   (cd server && pnpm db:migration:up)
   (cd server && pnpm db:seed)
   ```
1. Run the server
   ```bash
   (cd server && pnpm start:dev)
   ```
1. From a new terminal run the cloud functions emulator
   ```bash
   (cd functions && pnpm serve)
   ```
1. From a new terminal run the client app
   ```bash
   (cd client && flutter run)
   ```
