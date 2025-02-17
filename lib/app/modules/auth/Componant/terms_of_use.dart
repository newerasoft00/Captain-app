import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widget/privacy_policy_dialog.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "You are agreeing to our ",
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: "Privacy Policy! ",
            style: const TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'privacy_policy.md',
                    );
                  },
                );
              },
          ),
        ],
      ),
    );
  }
}
