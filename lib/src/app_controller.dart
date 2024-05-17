// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_app_shared/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'ai/generative_ai.dart';
import 'ai/prompt.dart';
import 'data_models.dart';

class AppController implements DisposableController {
  ValueListenable<FlutterWidget?> get selectedWidget => _selectedWidget;
  final _selectedWidget = ValueNotifier<FlutterWidget?>(null);

  ValueListenable<String?> get activeGeminiResponse => _activeGeminiResponse;
  final _activeGeminiResponse = ValueNotifier<String?>('');

  bool _busy = false;

  Future<void> selectWidget(FlutterWidget? widget) async {
    _selectedWidget.value = widget;
    if (widget == null) {
      return;
    }
    _askGeminiAboutWidget(widget.name);
  }

  Future<void> _askGeminiAboutWidget(String widgetName) async {
    if (_busy) return;
    _activeGeminiResponse.value = null;
    try {
      _busy = true;
      final response = await Gemini.instance.ask(generatePromptFor(widgetName));
      _activeGeminiResponse.value = response;
    } on GenerativeAIException catch (e) {
      _activeGeminiResponse.value = 'GenerativeAIException: $e';
    } catch (e) {
      _activeGeminiResponse.value = 'Something went wrong: $e';
    } finally {
      _busy = false;
    }
  }

  @override
  void dispose() {
    _selectedWidget.dispose();
    _activeGeminiResponse.dispose();
  }
}
