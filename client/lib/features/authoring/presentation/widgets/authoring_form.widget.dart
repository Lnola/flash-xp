import 'package:flashxp/features/authoring/logic/base_authoring.controller.dart';
import 'package:flashxp/features/authoring/presentation/builders/multiple_choice_question_form.builder.dart';
import 'package:flashxp/features/authoring/presentation/builders/question_form.builder.dart';
import 'package:flashxp/features/authoring/presentation/builders/self_assessment_question_form.builder.dart';
import 'package:flashxp/features/authoring/presentation/widgets/authoring_form_actions.widget.dart';
import 'package:flashxp/features/authoring/presentation/widgets/practice_mode_select.widget.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

extension on PracticeMode {
  QuestionFormBuilder get _builder => switch (this) {
        PracticeMode.multipleChoice => MultipleChoiceQuestionFormBuilder(),
        PracticeMode.selfAssessment => SelfAssessmentQuestionFormBuilder(),
      };

  Widget buildInputs(BaseAuthoringController controller) =>
      _builder.buildInputs(
        controller.questionsControllers,
        controller.removeQuestion,
        controller.toggleIsCorrect,
      );

  Widget buildLegend() => _builder.buildLegend();
}

class AuthoringFormWidget extends StatelessWidget {
  final BaseAuthoringController controller;
  final Function(BuildContext) submit;

  const AuthoringFormWidget({
    super.key,
    required this.controller,
    required this.submit,
  });

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
              const SizedBox(height: 8),
              PracticeModeSelectWidget(
                mode: controller.mode,
                updateMode: controller.updateMode,
              ),
              const SizedBox(height: 8),
              controller.mode.buildLegend(),
              controller.mode.buildInputs(controller),
              const SizedBox(height: 24),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AuthoringFormActionsWidget(
            addQuestion: controller.addQuestion,
            submit: submit,
          ),
        ),
      ],
    );
  }
}
