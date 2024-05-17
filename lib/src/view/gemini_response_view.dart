// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ai_widget_catalog/src/view/common.dart';
import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GeminiResponseView extends StatelessWidget {
  const GeminiResponseView({super.key, required this.response});

  final String? response;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AreaPaneHeader(
          title: const Text('Gemini Insights'),
          includeTopBorder: false,
          includeBottomBorder: false,
          actions: [
            CopyToClipboardControl(
              dataProvider: () => response,
            )
          ],
        ),
        Expanded(
          child: response == null || response!.isEmpty
              ? Center(
                  child: response == null
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Select a widget from the catalog to see '
                          'examples and explanations from Gemini.',
                        ),
                )
              : Markdown(
                  data: response!,
                  selectable: true,
                  onSelectionChanged: (text, selection, cause) => {},
                ),
        ),
      ],
    );
  }
}
