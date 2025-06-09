import 'package:flashxp/features/preview/data/deck.repository.dart';
import 'package:flashxp/features/preview/logic/preview.controller.dart';
import 'package:flashxp/features/preview/presentation/widgets/preview_info.widget.dart';
import 'package:flutter/material.dart';

class PreviewView extends StatefulWidget {
  const PreviewView({super.key});

  @override
  State<PreviewView> createState() => PreviewViewState();
}

class PreviewViewState extends State<PreviewView> {
  late final PreviewController controller;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = PreviewController(DeckRepository());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PreviewInfoWidget(
            label: 'Description',
            content: controller.description,
          ),
        ],
      ),
    );
  }
}
