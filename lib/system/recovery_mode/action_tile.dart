import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class RecoveryActionTile extends StatelessWidget {
  final String title;
  final String description;
  final bool showConfirmDialog;

  const RecoveryActionTile({
    required this.title,
    required this.description,
    this.showConfirmDialog = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      onTap: () async => _action(context),
    );
  }

  Future<void> _action(BuildContext context) async {
    // ignore: invalid_use_of_visible_for_testing_member
    Hive.resetAdapters();
    await Hive.close();

    try {
      if (showConfirmDialog) {
        final execute = await confirm(context);
        if (execute) {
          await action(context);
          success(context);
        }
      } else {
        await action(context);
        success(context);
      }
    } catch (error, stack) {
      failure(context, error, stack);
    }
  }

  Future<void> action(BuildContext context);

  void success(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SimpleDialog(
        title: Text('Success'),
        children: [
          Text('Action completed successfully.'),
        ],
        contentPadding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 12.0,
          bottom: 24.0,
        ),
      ),
    );
  }

  void failure(BuildContext context, dynamic error, StackTrace stack) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Error'),
        children: [
          Text(error.toString()),
          Text(stack.toString()),
        ],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
      ),
    );
  }

  Future<bool> confirm(BuildContext context) async {
    bool result = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are You Sure?'),
        content: RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Are you sure you want to '),
              TextSpan(text: description.toLowerCase()),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              result = true;
              Navigator.of(context).pop();
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );

    return result;
  }
}
