import { Provider } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as admin from 'firebase-admin';

export const FirebaseProvider: Provider = {
  provide: 'FIREBASE_APP',
  inject: [ConfigService],
  useFactory: () => {
    const firebaseConfig = process.env.FIREBASE_CREDENTIAL
      ? (JSON.parse(process.env.FIREBASE_CREDENTIAL) as admin.ServiceAccount)
      : ({
          type: process.env.FIREBASE_TYPE,
          projectId: process.env.FIREBASE_PROJECT_ID,
          privateKeyId: process.env.FIREBASE_PRIVATE_KEY_ID,
          privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n'),
          clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
          clientId: process.env.FIREBASE_CLIENT_ID,
          authUri: process.env.FIREBASE_AUTH_URI,
          tokenUri: process.env.FIREBASE_TOKEN_URI,
          authProviderX509CertUrl:
            process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL,
          clientX509CertUrl: process.env.FIREBASE_CLIENT_X509_CERT_URL,
          universeDomain: process.env.FIREBASE_UNIVERSE_DOMAIN,
        } as admin.ServiceAccount);

    return admin.initializeApp({
      credential: admin.credential.cert(firebaseConfig),
    });
  },
};
