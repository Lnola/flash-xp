import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/widgets/create_input.widget.dart';
import 'package:flutter/material.dart';

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => CreateViewState();
}

class CreateViewState extends State<CreateView> {
  late final CreateController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = CreateController();
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(top: 8, bottom: 18),
      child: Column(
        spacing: 24,
        children: [
          CreateInput(
            label: 'Full title',
            controller: controller.titleController,
          ),
        ],
      ),
    );
  }
}
