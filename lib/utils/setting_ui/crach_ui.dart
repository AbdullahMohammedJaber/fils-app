
import 'package:flutter/material.dart';

class NeonErrorView extends StatefulWidget {
  final VoidCallback onRetry;
  final VoidCallback? onBack;

  const NeonErrorView({
    super.key,
    required this.onRetry,
    this.onBack,
  });

  @override
  State<NeonErrorView> createState() => _NeonErrorViewState();
}

class _NeonErrorViewState extends State<NeonErrorView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 💥 Neon Error Icon
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent
                            .withOpacity(0.6 * _controller.value),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.deepOrange
                            .withOpacity(0.4 * _controller.value),
                        blurRadius: 60,
                        spreadRadius: 15,
                      ),
                    ],
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFFFF5252),
                        Color(0xFFFF6D00),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.black,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 32),

                // 📝 Title
                const Text(
                  'Something Went Wrong',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),

                const SizedBox(height: 12),

                // 📄 Subtitle
                Text(
                  'An unexpected error occurred.\nPlease try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 36),

                // 🔁 Retry Button
                GestureDetector(
                  onTap: widget.onRetry,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF5252),
                          Color(0xFFFF6D00),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Text(
                      'TRY AGAIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                // 🔙 Optional Back Button
                if (widget.onBack != null) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: widget.onBack,
                    child: const Text(
                      'Go Back',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
