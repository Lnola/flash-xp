import 'package:flashxp/features/create/data/create.repository.dart';
import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flashxp/features/create/presentation/builders/multiple_choice_question_form.builder.dart';
import 'package:flashxp/features/create/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/create/presentation/builders/self_assessment_question_form.builder.dart';
import 'package:flashxp/features/create/presentation/widgets/create_form_actions.widget.dart';
import 'package:flashxp/features/create/presentation/widgets/practice_mode_select.widget.dart';
import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

extension on PracticeMode {
  QuestionFormBuilder get _builder => switch (this) {
        PracticeMode.multipleChoice => MultipleChoiceQuestionFormBuilder(),
        PracticeMode.selfAssessment => SelfAssessmentQuestionFormBuilder(),
      };

  Widget buildInputs(CreateController controller) => _builder.buildInputs(
        controller.questionsControllers,
        controller.removeQuestion,
        controller.toggleIsCorrect,
      );

  Widget buildLegend() => _builder.buildLegend();
}

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
    controller = CreateController(CreateRepository());
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
    return Stack(
      children: [
        SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(top: 8, bottom: 120),
          child: Column(
            spacing: 8,
            children: [
              FlashTextInput(
                label: 'Full title',
                controller: controller.titleController,
              ),
              FlashTextInput(
                label: 'Description',
                controller: controller.descriptionController,
              ),
              const SizedBox(height: 16),
              controller.mode.buildLegend(),
              controller.mode.buildInputs(controller),
              PracticeModeSelectWidget(
                mode: controller.mode,
                updateMode: controller.updateMode,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CreateFormActionsWidget(
            addQuestion: controller.addQuestion,
            submit: _submit,
          ),
        ),
      ],
    );
  }
}
