import 'package:flutter/material.dart';
import 'package:whale_stock/ui/widgets/toast_notification.dart';

class ToastManager {
  static OverlayEntry? _currentEntry;

  static void show(BuildContext context, String message,
      {ToastType type = ToastType.info}) {
    _currentEntry?.remove();
    _currentEntry = null;

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ToastNotification(
              message: message,
              type: type,
              onDismiss: () {
                _currentEntry?.remove();
                _currentEntry = null;
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(_currentEntry!);
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message, type: ToastType.success);
  }

  static void showError(BuildContext context, String message) {
    show(context, message, type: ToastType.error);
  }

  static void showInfo(BuildContext context, String message) {
    show(context, message, type: ToastType.info);
  }
}
