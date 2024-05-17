// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_copy_to_clipboard_desktop.dart'
    if (dart.library.js_interop) '_copy_to_clipboard_web.dart';

/// Attempts to copy a String of `data` to the clipboard.
///
/// Shows a `successMessage` [Notification] on the passed in `context`, if the
/// copy is successfully done using the [Clipboard.setData] api. Otherwise it
/// attempts to post the [data] to the parent frame where the parent frame will
/// try to complete the copy (this fallback will only work in VSCode).
Future<void> copyToClipboard(
  String data,
  String? successMessage,
) async {
  try {
    await Clipboard.setData(
      ClipboardData(
        text: data,
      ),
    );
  } catch (e) {
    copyToClipboardVSCode(data);
  }
}
