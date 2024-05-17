// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ai_widget_catalog/src/ai/generative_ai.dart';
import 'package:ai_widget_catalog/src/data_models.dart';
import 'package:ai_widget_catalog/src/view/api_key.dart';
import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_app_shared/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_controller.dart';
import 'view/catalog.dart';
import 'view/gemini_response_view.dart';

class AiWidgetCatalog extends StatefulWidget {
  const AiWidgetCatalog({super.key});

  @override
  State<AiWidgetCatalog> createState() => _AiWidgetCatalogState();
}

class _AiWidgetCatalogState extends State<AiWidgetCatalog>
    with AutoDisposeMixin {
  late final AppController controller;

  String? _apiKey;

  @override
  void initState() {
    super.initState();
    controller = AppController();

    if (!kReleaseMode) {
      const apiKeyFromEnv = String.fromEnvironment('GOOGLE_AI_API_KEY');
      if (apiKeyFromEnv.isNotEmpty) {
        _apiKey = apiKeyFromEnv;
        Gemini.initialize(_apiKey!);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_apiKey == null) {
      return ApiKeyWidget(
        onSubmitted: (key) {
          setState(() {
            _apiKey = key;
            Gemini.initialize(_apiKey!);
          });
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.all(denseSpacing),
      child: SplitPane(
        axis: Axis.vertical,
        initialFractions: const [0.6, 0.4],
        children: [
          RoundedOutlinedBorder(
            clip: true,
            child: ValueListenableBuilder<FlutterWidget?>(
              valueListenable: controller.selectedWidget,
              builder: (context, selected, _) {
                return WidgetCatalog(
                    controller: controller, selected: selected);
              },
            ),
          ),
          RoundedOutlinedBorder(
            clip: true,
            child: ValueListenableBuilder<String?>(
              valueListenable: controller.activeGeminiResponse,
              builder: (context, response, _) {
                return GeminiResponseView(response: response);
              },
            ),
          ),
        ],
      ),
    );
  }
}
