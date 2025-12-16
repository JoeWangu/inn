import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/security_controller.dart';

class AppLifecycleWrapper extends ConsumerStatefulWidget {
  final Widget child;
  final GoRouter router;

  const AppLifecycleWrapper({
    super.key,
    required this.child,
    required this.router,
  });

  @override
  ConsumerState<AppLifecycleWrapper> createState() =>
      _AppLifecycleWrapperState();
}

class _AppLifecycleWrapperState extends ConsumerState<AppLifecycleWrapper> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onResume: _onResume, onPause: _onPause);
    // Initial check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(securityControllerProvider.notifier).checkAutoLock();
    });
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _onResume() {
    ref.read(securityControllerProvider.notifier).checkAutoLock();
  }

  void _onPause() {
    // Optional: if we wanted to lock immediately on minimize, we'd do it here.
    // But we handle it via checkAutoLock on resume comparing timestamps.
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(securityControllerProvider, (previous, next) {
      next.whenData((state) {
        if (state.isLocked) {
          // Avoid pushing if already there?
          // How to check?
          final location =
              widget.router.routerDelegate.currentConfiguration.fullPath;
          if (location != '/lock_screen') {
            widget.router.push('/lock_screen');
          }
        }
      });
    });

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        ref.read(securityControllerProvider.notifier).reportActivity();
      },
      onPointerHover: (_) {
        // Also tracking hover might be good for desktop/web
        ref.read(securityControllerProvider.notifier).reportActivity();
      },
      child: widget.child,
    );
  }
}
