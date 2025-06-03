import 'package:flashxp/pages/create/views/create_view.dart';
import 'package:flashxp/widgets/layout/flash_layout.dart';
import 'package:flutter/material.dart';

class CreateNestedView extends StatelessWidget {
  const CreateNestedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlashLayout(
      title: 'Create Nested Page',
      body: CreateView(),
    );
  }
}
