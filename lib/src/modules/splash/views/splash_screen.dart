import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/autentication_bloc/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state.status == AuthenticationStatus.authenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) context.go('/home');
            });
            return Container();
          } else if(state.status == AuthenticationStatus.unauthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) context.go('/login');
            });
            return Container();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}