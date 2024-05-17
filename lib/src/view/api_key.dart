// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

class ApiKeyWidget extends StatelessWidget {
  ApiKeyWidget({required this.onSubmitted, super.key});
  final ValueChanged onSubmitted;
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: DevToolsDialog(
        title: const Text('You need a Google AI API Key'),
        content: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'To use the Gemini API, enter your API key.\n\n'
                        'If you don\'t have a key, create one in Google AI Studio.'
                        'See the ',
                    style: theme.regularTextStyle,
                    children: [
                      LinkTextSpan(
                        link: const Link(
                          display: 'Gemini API quickstart',
                          url:
                              'https://ai.google.dev/gemini-api/docs/quickstart?lang=dart',
                        ),
                        context: context,
                      ),
                      const TextSpan(text: ' guide for more info.'),
                    ],
                  ),
                ),
                const SizedBox(height: defaultSpacing),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          hintText: 'Enter your API key',
                        ),
                        controller: _apiKeyController,
                        onSubmitted: (value) {
                          onSubmitted(value);
                        },
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    TextButton(
                      onPressed: () {
                        onSubmitted(_apiKeyController.value.text);
                      },
                      child: const Text('Go'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
