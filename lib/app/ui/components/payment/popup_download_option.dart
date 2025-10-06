import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_app/core/helpers/generate_receipt.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

enum AnimationStyles { defaultStyle, custom, none }

enum Menu { receipt, certificate }

class PopupDownloadOption extends StatefulWidget {
  const PopupDownloadOption(
    this.receiptNumber,
    this.date,
    this.name,
    this.dni,
    this.subtotal,
    {super.key});

  final String receiptNumber;
  final String date;
  final String name;
  final String dni;
  final double subtotal;

  @override
  State<PopupDownloadOption> createState() => _PopupDownloadOptionState();
}

class _PopupDownloadOptionState extends State<PopupDownloadOption> {
  AnimationStyle? _animationStyle;

  @override
  Widget build(BuildContext context) {
    _animationStyle = const AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: Duration(seconds: 1),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PopupMenuButton<Menu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color:
                    AppColors.shadowAppBarColor(context), // 👈 color del borde
                width: 2, // grosor del borde
              ),
            ),
            elevation: 0,
            offset: const Offset(-20, 60), // 👈 Esto baja el menú 20px
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(16),
            shadowColor: const Color.fromARGB(145, 158, 158, 158).withValues(),
            popUpAnimationStyle: _animationStyle,
            icon: const Icon(
              Bootstrap.download,
              color: AppColors.secondConst,
            ),
            onSelected: (Menu item) async {
              switch (item) {
                case Menu.receipt:
                  final double igv = widget.subtotal * 0.18;
                  await generateReceipt(
                      receiptNumber: widget.receiptNumber,
                      date: widget.date,
                      name: widget.name,
                      dni: widget.dni,
                      subtotal: widget.subtotal,
                      igv: igv,
                      total: widget.subtotal);
                  break;
                case Menu.certificate:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialogComponent(
                        onTapButton: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                          context.go(AppRoutesName.LOGIN);
                        },
                        title: "¿Seguro que quieres salir de MiCip?",
                      );
                    },
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                height: 10.0,
                value: Menu.receipt,
                child: ListTile(
                  leading: Icon(Bootstrap.receipt),
                  title: Text('Comprobante'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<Menu>(
                height: 10.0,
                value: Menu.certificate,
                child: ListTile(
                  leading: Icon(Bootstrap.file_earmark_text),
                  title: Text('Certifiado'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
