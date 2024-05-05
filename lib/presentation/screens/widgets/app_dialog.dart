import 'package:flutter/material.dart';

class AppDialog {
  static Future<bool?> showLeavePageDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Leave Page'),
          content: const Text('Your answers will not be saved. Are you sure you want to leave?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static showSubmitDialog(BuildContext context, VoidCallback onSubmitted) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit exam'),
          content: const Text('Are you sure you want to submit the exam?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onSubmitted();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
