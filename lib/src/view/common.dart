import 'dart:async';

import 'package:ai_widget_catalog/src/view/copy_to_clipboard/copy_to_clipboard.dart';
import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

/// Control that copies `data` to the clipboard.
///
/// If it succeeds, it displays a notification with `successMessage`.
class CopyToClipboardControl extends StatelessWidget {
  const CopyToClipboardControl({
    super.key,
    this.dataProvider,
    this.successMessage = 'Copied to clipboard.',
    this.tooltip = 'Copy to clipboard',
    this.buttonKey,
    this.size,
  });

  final String? Function()? dataProvider;
  final String? successMessage;
  final String tooltip;
  final Key? buttonKey;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final onPressed = dataProvider == null
        ? null
        : () {
            unawaited(
              copyToClipboard(dataProvider!() ?? '', successMessage),
            );
          };
    final size = this.size ?? defaultIconSize;
    return SizedBox(
      height: size,
      child: ToolbarAction(
        icon: Icons.content_copy,
        tooltip: tooltip,
        onPressed: onPressed,
        key: buttonKey,
        size: size,
      ),
    );
  }
}

/// A wrapper around a TextButton, an Icon, and an optional Tooltip; used for
/// small toolbar actions.
class ToolbarAction extends StatelessWidget {
  const ToolbarAction({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    super.key,
    this.size,
    this.style,
    this.color,
  });

  final TextStyle? style;
  final IconData icon;
  final Color? color;
  final String? tooltip;
  final VoidCallback? onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: style,
      ),
      onPressed: () {
        onPressed?.call();
      },
      child: Icon(
        icon,
        size: size ?? actionsIconSize,
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
    );

    return tooltip == null
        ? button
        : DevToolsTooltip(
            message: tooltip,
            child: button,
          );
  }
}