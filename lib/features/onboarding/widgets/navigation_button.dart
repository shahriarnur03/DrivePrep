import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.isLastPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: PrimaryButton(
        text: isLastPage ? 'Get Started' : 'Next',
        onPressed: onPressed,
      ),
    );
  }
}
