import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/bloc/account/account_bloc.dart';
import 'package:online_grocery/presentation/bloc/account/account_event.dart';
import 'package:online_grocery/presentation/bloc/account/account_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountBloc>(param1: FailureMapper(context)),
      child: const _AccountScreenView(),
    );
  }
}

class _AccountScreenView extends StatelessWidget {
  const _AccountScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AccountBloc, AccountState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.userInfo?.image ?? ''),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.userInfo?.fullName ?? ''),
                      SizedBox(height: 10),
                      Text(state.userInfo?.email ?? ''),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.isLoading) {
            CommonDialogs.showLoadingDialog(context);
          } else {
            CommonDialogs.hideLoadingDialog(context);
            if (state.apiError != null) {
              CommonDialogs.showErrorDialog(
                context: context,
                title: 'Error',
                message: state.apiError!,
                onTap: () {
                  context.read<AccountBloc>().add(OnClearErrorEvent());
                },
              );
            }
          }
        },
      ),
    );
  }
}
