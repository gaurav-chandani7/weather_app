import 'package:flutter/widgets.dart';

class CommonPageErrorWidget extends StatelessWidget {
  const CommonPageErrorWidget({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          message ?? 'Something went wrong.',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
