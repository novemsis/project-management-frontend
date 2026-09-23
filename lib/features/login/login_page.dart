import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account/account_cubit.dart';
import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/t_snackbar.dart';
import '../../core/typography/t_text_large.dart';
import '../../core/typography/t_text_small.dart';
import '../../core/widgets/t_elevated_button.dart';
import '../../core/widgets/t_text_button.dart';
import '../../core/widgets/t_text_field.dart';
import '../../core/wrapper/basic_layout_wrapper.dart';
import '../../widgets/t_card.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return BasicLayoutWrapper(
      showTitleBar: false,
      showBottomBar: false,
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: TSpacings.p2),
              child: TTextLarge(
                'VisionFlow',
                color: TColors.title,
              ),
            ),
            TCard(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: TSpacings.p1),
                      child: TTextfield(
                        labelText: 'Username',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: TSpacings.p1),
                      child: TTextfield(
                        labelText: 'Password',
                        obscureText: true,
                      ),
                    ),
                    TTextButton(
                      // ToDo: register account
                      onPressed: () => print('hi'),
                      child: TTextSmall('register new Account'),
                    ),
                    TElevatedButton(
                      onPressed: () async {
                        final result = await ref
                            .read(AccountCubit.provider.bloc)
                            .login(_formKey.currentState!.fields.first.value as String, _formKey.currentState!.fields.elementAt(1).value as String);
                        if (!result) TSnackBar.error(context, 'error on login');
                      },
                      child: TTextSmall(
                        'Login',
                        color: TColors.elevatedButtonText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
