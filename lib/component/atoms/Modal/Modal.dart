import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final String title;
  final String? description;
  final String? buttonText;

  const Modal(
      {required this.title, this.description, this.buttonText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            Text(description ?? ''),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(buttonText ?? '닫기'),
            ),
          ],
        ),
      ),
    );
  }
}
