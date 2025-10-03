
import 'package:cip_payment_app/app/ui/views/home/views/%20home_view_mobile.dart';
import 'package:cip_payment_app/app/ui/views/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    

    return ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: Builder(
          
          builder: (context){
            final homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          // Se ejecuta solo una vez cuando se construye el widget
          WidgetsBinding.instance.addPostFrameCallback((_) {
             
          });
           return HomeViewMobile(homeProvider: homeProvider);
          }
           ));
  }
}

