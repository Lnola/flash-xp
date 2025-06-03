import 'package:flashxp/main.dart';
import 'package:flashxp/pages/create/views/create_view.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: 'Create',
      body: CreateView(),
    );
  }
}
