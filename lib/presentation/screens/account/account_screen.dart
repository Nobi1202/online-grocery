import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/bloc/account/account_bloc.dart';
import 'package:online_grocery/presentation/bloc/account/account_event.dart';
import 'package:online_grocery/presentation/bloc/account/account_state.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_event.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_state.dart';
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
          return SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          state.userInfo?.image ?? '',
                        ),
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

                  _buildAccountItem(title: context.appLocalizations.orders),
                  _buildAccountItem(title: context.appLocalizations.myDetails),
                  _buildAccountItem(
                    title: context.appLocalizations.deliveryAddress,
                  ),
                  _buildAccountItem(
                    title: context.appLocalizations.paymentMethods,
                  ),
                  _buildAccountItem(title: context.appLocalizations.promoCard),
                  _buildAccountItem(
                    title: context.appLocalizations.notifications,
                  ),
                  _buildAccountItem(title: context.appLocalizations.help),
                  _buildAccountItem(title: context.appLocalizations.about),
                  _buildAccountItem(
                    title: context.appLocalizations.languges,
                    isSwitch: true,
                  ),
                ],
              ),
            ),
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

  Padding _buildAccountItem({required String title, bool isSwitch = false}) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(width: 20),
          Text(title),
          Spacer(),
          if (isSwitch)
            BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return Switch(
                  value: state.locale == 'vi',
                  onChanged: (value) {
                    context.read<LocaleBloc>().add(
                      OnLocaleChangedEvent(value ? 'vi' : 'en'),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
