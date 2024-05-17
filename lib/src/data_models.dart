// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class FlutterWidget {
  FlutterWidget({required this.name, required this.widgetExample});

  factory FlutterWidget.custom({required String name}) {
    return FlutterWidget(name: name, widgetExample: const Placeholder());
  }

  final String name;
  final Widget widgetExample;
}
