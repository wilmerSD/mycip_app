import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor(context),
         
        ),
        child: Row(
          children: [
            // 🔙 Botón de retroceso
            GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorTheme.onInverseSurface, // fondo suave
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 📌 Título centrado
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBasic(context),
                ),
              ),
            ),
            const SizedBox(width: 36), // espacio para balancear el botón
          ],
        ),
      ),
    );
  }
}
