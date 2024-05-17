// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  Gemini._();

  static Gemini get instance {
    if (!_initialized) {
      throw Exception(
        'Cannot access Gemini.instance before Gemini.initialize(apiKey) has been called.',
      );
    }
    return _instance;
  }

  static final Gemini _instance = Gemini._();

  static initialize(String apiKey) {
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    chat = model.startChat();
    _initialized = true;
  }

  static late final GenerativeModel model;
  static late ChatSession chat;
  static bool _initialized = false;

  Future<String> ask(String prompt) async {
    if (!_initialized) return '';
    final content = Content.text(prompt);
    final response = await chat.sendMessage(content);
    return response.text ?? 'Something went wrong. Gemini had nothing to say.';
  }

  void resetChat() {
    chat = model.startChat();
  }
}
