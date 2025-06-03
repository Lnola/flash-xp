import 'package:flashxp/pages/create/views/create_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Create',
      body: CreateView(),
    );
  }
}
