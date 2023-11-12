import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    super.key,
    this.radius = 8,
    required this.mdFileName,
  }) : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension');

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150))
                  .then((value) {
                return rootBundle
                    .loadString('assets/Privacy & Policy/privacy_policy.md');
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data!,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 5)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const AutoSizeText(
                "CLOSE",
                maxFontSize: 22,
                maxLines: 20,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
