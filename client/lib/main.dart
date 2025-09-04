import 'package:firebase_core/firebase_core.dart';
import 'package:flashxp/router.dart';
import 'package:flashxp/shared/config/firebase.options.dart';
import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'flash-xp',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
