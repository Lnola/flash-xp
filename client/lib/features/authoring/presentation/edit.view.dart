import 'package:flashxp/features/authoring/data/authoring.repository.dart';
import 'package:flashxp/features/authoring/logic/edit.controller.dart';
import 'package:flashxp/features/authoring/presentation/widgets/authoring_form.widget.dart';
import 'package:flashxp/shared/presentation/composables/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditView extends StatefulWidget {
  final int deckId;

  const EditView({super.key, required this.deckId});

  @override
  State<EditView> createState() => EditViewState();
}

class EditViewState extends State<EditView> {
  late final EditController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = EditController(widget.deckId, AuthoringRepository());
    controller.addListener(_onControllerUpdated);
    _loadDeck();
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  void _loadDeck() async {
    final result = await controller.getDeck();
    if (result.error != null && mounted) {
      useSnackbar(context, result.error, 'Failed to load deck');
      context.replace('/404');
      return;
    }
    controller.populateForm(result.data);
  }

  void _submit(BuildContext context) async {
    final result = await controller.submit();
    if (!context.mounted) return;
    useSnackbar(context, result.error, 'Deck successfully edited!');
    if (result.error != null) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AuthoringFormWidget(
      controller: controller,
      submit: _submit,
    );
  }
}
