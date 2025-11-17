import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(
            color: disabled
                ? const Color(0xFFE1E1E1).withOpacity(0.5)
                : const Color(0xFFE1E1E1),
          ),
          foregroundColor: disabled
              ? Colors.black.withOpacity(0.4)
              : Colors.black,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}
