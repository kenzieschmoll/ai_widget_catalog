// Copyright 2024 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

import '../app_controller.dart';
import '../data_models.dart';

class WidgetCatalog extends StatefulWidget {
  const WidgetCatalog({
    required this.controller,
    required this.selected,
    super.key,
  });

  final AppController controller;
  final FlutterWidget? selected;

  @override
  State<WidgetCatalog> createState() => _WidgetCatalogState();
}

class _WidgetCatalogState extends State<WidgetCatalog> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AreaPaneHeader(
          title: Text('Flutter Widget Catalog + Gemini Insights'),
          includeTopBorder: false,
          includeBottomBorder: false,
        ),
        Expanded(
          child: Material(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: catalogWidgets.length,
              itemBuilder: (context, index) {
                final catalogWidget = catalogWidgets[index];
                return GridTile(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 100.0,
                      maxWidth: 100.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () =>
                          widget.controller.selectWidget(catalogWidget),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: catalogWidget.widgetExample,
                          ),
                          const SizedBox(height: defaultSpacing),
                          Text(
                            catalogWidget.name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const PaddedDivider(),
        Padding(
          padding: const EdgeInsets.only(
            bottom: defaultSpacing,
            left: denseSpacing,
            right: denseSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Don\'t see the widget you are looking for? Enter a Widget name manually.',
                style: Theme.of(context).boldTextStyle,
              ),
              const SizedBox(height: denseSpacing),
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Widget name',
                ),
                onSubmitted: (value) => widget.controller.selectWidget(
                  FlutterWidget.custom(name: value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<FlutterWidget> catalogWidgets = [
  FlutterWidget(
    name: 'Container',
    widgetExample: Container(
      color: Colors.blue,
      height: 40,
      width: 40,
    ),
  ),
  FlutterWidget(
    name: 'IconButton',
    widgetExample: SizedBox(
      height: 40,
      width: 40,
      child: IconButton(
        icon: const Icon(Icons.watch_rounded),
        onPressed: () {},
      ),
    ),
  ),
  FlutterWidget(
    name: 'Inkwell',
    widgetExample: InkWell(
      onTap: () {},
      child: Container(
        color: Colors.green,
        height: 40,
        width: 40,
      ),
    ),
  ),
  FlutterWidget(
    name: 'Text',
    widgetExample: Center(
      child: Builder(
        builder: (context) => Text(
          'Hello, Flutter!',
          textAlign: TextAlign.center,
          style: Theme.of(context).subtleTextStyle,
        ),
      ),
    ),
  ),
  FlutterWidget(
    name: 'TextField',
    widgetExample: const TextField(),
  ),
  FlutterWidget(
    name: 'GridView',
    widgetExample: GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        4,
        (index) => Container(
          color: Colors.primaries[index],
          height: 12,
          width: 12,
        ),
      ),
    ),
  ),
  FlutterWidget(
    name: 'ListView',
    widgetExample: RoundedOutlinedBorder(
      child: ListView(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            child: Text(
              'Item ${index + 1}',
              textScaler: const TextScaler.linear(0.8),
            ),
          ),
        ),
      ),
    ),
  ),
  FlutterWidget(
    name: 'Row',
    widgetExample: Row(
      children: List.generate(
        3,
        (index) => Container(
          color: Colors.primaries[index],
          height: 15,
          width: 15,
        ),
      ),
    ),
  ),
  FlutterWidget(
    name: 'Column',
    widgetExample: Column(
      children: List.generate(
        3,
        (index) => Container(
          color: Colors.primaries[index],
          height: 15,
          width: 15,
        ),
      ),
    ),
  ),
];
