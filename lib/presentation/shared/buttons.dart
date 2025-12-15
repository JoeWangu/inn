import 'package:flutter/material.dart';
import 'package:inn/core/utils/color_util.dart';

class InnButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool filled;
  final ColorScheme cs;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;

  const InnButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.filled = true,
    required this.cs,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final c1 = lighten(cs.primary, 0.05);
    final c2 = darken(cs.primary, 0.05);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: filled
          ? ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style:
                  ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.disabled)) {
                        return cs.surfaceDim.withValues(alpha: 0.5);
                      }
                      return null;
                    }),
                    shadowColor: WidgetStateProperty.all(cs.outlineVariant),
                    elevation: WidgetStateProperty.all(8),
                  ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [c1, c2]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: cs.onPrimary,
                          ),
                        )
                      : Text(
                          buttonText,
                          style: TextStyle(color: cs.onPrimary, fontSize: 18),
                        ),
                ),
              ),
            )
          : OutlinedButton(onPressed: onPressed, child: Text(buttonText)),
    );
  }
}
