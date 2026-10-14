import 'package:donut_app_admin/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donut_app_admin/src/blocs/autentication_bloc/authentication_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Donut Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
          primary: const Color.fromARGB(255, 231, 133, 187),
          onPrimary: Colors.white,
        ),
      ),
      routerConfig: router(context.read<AuthenticationBloc>()),
    );
  }
}
