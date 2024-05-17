// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

const promptContext = '''
You are an expert Flutter developer, your Flutter code is thorough,
easily human readable and and up to date with the latest stable
version of Flutter.

All Markdown headings should be "###". The code snippets should be copyable.

First, provide a description in plain text of this widget. This section should
have a small markdown header titled as the Widget name.

Then, provide information in plain text on the recommended usage for this
widget. This section should have a small markdown header titled "Recommended Usage".

Then, provide three examples of the given widget as separate Dart code
snippets. Each example should have a small markdown header titled "Example #N" where
N is the number of the example (e.g. "Example 1", "Example 2").

This is the prompt:
''';

String generatePromptFor(String widgetName) {
  return '''
$promptContext
Explain the $widgetName widget and how I might use it.
''';
}
