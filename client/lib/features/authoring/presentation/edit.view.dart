import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/logic/create.controller.dart';
import 'package:flashxp/features/authoring/presentation/widgets/authoring_form.widget.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flutter/material.dart';

class EditView extends StatefulWidget {
  final int deckId;

  const EditView({super.key, required this.deckId});

  @override
  State<EditView> createState() => EditViewState();
}

class EditViewState extends State<EditView> {
  late final CreateController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = CreateController(AuthoringRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    final result = await controller.submit();
    if (!context.mounted) return;
    useSnackbar(context, result.error, 'Deck successfully created!');
  }

  @override
  Widget build(BuildContext context) {
    return AuthoringFormWidget(
      controller: controller,
      submit: _submit,
    );
  }
}
