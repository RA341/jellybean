import 'package:flutter/material.dart';
import 'package:jellybean/utils/setup.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    // final message = state.extra;
    // logDebug('Error: $message');
    return const Scaffold(
      body: Text(
        'Whoops something went wrong, try restarting the app, '
        'if the issue persists open a issue on github',
      ),
    );
  }
}
