import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:url_launcher/url_launcher.dart';

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  // The recogniser must be disposed to avoid memory leaks.
  // late final TapGestureRecognizer _linkRecognizer;

  // @override
  // void initState() {
  //   super.initState();
  //   _linkRecognizer = TapGestureRecognizer()..onTap = _openTerms;
  // }

  // @override
  // void dispose() {
  //   _linkRecognizer.dispose();
  //   super.dispose();
  // }

  // Future<void> _openTerms() async {
  //   const url = 'https://example.com/terms'; // <-- replace with your real URL
  //   final uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     // You could show a snackbar or fallback UI here.
  //     debugPrint('Could not launch $url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Wrap the whole row in InkWell so the *checkbox* toggles when the user taps the text.
    return
    // InkWell(
    //   onTap: () => widget.onChanged(!widget.value),
    //   borderRadius: BorderRadius.circular(4),
    //   child:
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ① The actual checkbox
        Checkbox(
          checkColor: Theme.of(context).colorScheme.onPrimary,
          // fillColor: WidgetStateProperty.resolveWith(getColor),
          value: widget.value,
          onChanged: widget.onChanged,
        ),
        const SizedBox(width: 8),
        // ② RichText with a clickable span
        Flexible(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  // recognizer: _linkRecognizer,
                  // Accessibility hint for screen readers
                  semanticsLabel: 'Terms and Conditions, opens in browser',
                ),
              ],
            ),
          ),
        ),
      ],
    );
    // );
  }
}
