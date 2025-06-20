import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    return Center(
      child: FlashButton(
        onPressed: () async {
          await authService.signOut();
          // TODO: Handle sign out properly
          context.go('/auth');
        },
        label: 'Sign Out',
      ),
    );
  }
}
