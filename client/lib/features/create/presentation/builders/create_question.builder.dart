import 'package:flashxp/features/create/logic/create.controller.dart';
import 'package:flutter/material.dart';

abstract class CreateQuestionBuilder {
  Widget buildInputs(CreateController controller);
  Widget buildLegend(CreateController controller);
}
