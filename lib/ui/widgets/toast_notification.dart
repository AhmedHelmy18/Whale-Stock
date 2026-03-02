import 'package:flutter/material.dart';
import 'package:whale_stock/core/theme/app_theme.dart';
import 'dart:ui';

enum ToastType { success, error, info }

class ToastNotification extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;

  const ToastNotification({
    super.key,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<ToastNotification> createState() => _ToastNotificationState();
}

class _ToastNotificationState extends State<ToastNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (widget.type) {
      case ToastType.success:
        icon = Icons.check_circle_outline;
        color = AppTheme.success;
        break;
      case ToastType.error:
        icon = Icons.error_outline;
        color = AppTheme.alertRed;
        break;
      case ToastType.info:
        icon = Icons.info_outline;
        color = AppTheme.primaryTeal;
        break;
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 28),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
