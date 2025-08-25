import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/bloc/login/login_bloc.dart';
import 'package:online_grocery/presentation/bloc/login/login_event.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';
import 'package:online_grocery/presentation/shared/app_button.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(param1: FailureMapper(context)),
      child: const LoginScreenView(),
    );
  }
}

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isLoading) {
            CommonDialogs.showLoadingDialog(context);
          } else {
            CommonDialogs.hideLoadingDialog(context);
            if (state.isSuccess) {
              context.go(RouteName.bottomTab);
            }
            if (state.apiErrorMsg.isNotEmpty) {
              CommonDialogs.showErrorDialog(
                context: context,
                title: context.appLocalizations.error,
                message: state.apiErrorMsg,
              );
            }
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                context.go(RouteName.bottomTab);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 20.h),
                AppButton(
                  onTap: () {
                    context.read<LoginBloc>().add(
                      OnLoginEvent(
                        _usernameController.text.trim(),
                        _passwordController.text.trim(),
                      ),
                    );
                  },
                  content: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
