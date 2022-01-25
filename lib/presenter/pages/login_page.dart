import 'package:firebase_authentication_microfront/core/constants/exports.dart';
import 'package:firebase_authentication_microfront/presenter/pages/components/warn_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../exports.dart';

class LoginPage extends GetView<AuthController> {
  final Function() goToRegister;
  final Function() goToResetPassword;
  final Function() onSignIn;

  LoginPage(
      {required this.goToRegister,
      required this.goToResetPassword,
      required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: controller.loginForm,
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              AppInfoMedia(
                visible: false,
              ),
              Text(AuthI10n.signInTitle),
              SizedBox(
                height: 16,
              ),
              ReactiveTextField(
                formControlName: AuthFields.email,
                validationMessages: (control) => {
                  ValidationMessage.required: AuthI10n.emailRequired,
                  ValidationMessage.email: AuthI10n.emailInvalid
                },
                decoration: InputDecoration(
                    hintText: AuthI10n.emailPlaceholder,
                    label: Text(AuthI10n.emailLabel)),
              ),
              SizedBox(
                height: 8,
              ),
              ReactiveTextField(
                formControlName: AuthFields.password,
                validationMessages: (control) =>
                    {ValidationMessage.required: AuthI10n.passwordRequired},
                decoration: InputDecoration(
                    hintText: AuthI10n.passwordPlaceholder,
                    label: Text(AuthI10n.passwordLabel)),
                obscureText: true,
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => WarnInfo(
                  visible: controller.signInErrorMessage.value.isNotEmpty,
                  text: controller.signInErrorMessage.value,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: onSignIn, child: Text(AuthI10n.signInButton)),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: goToResetPassword,
                  child: Text(AuthI10n.forgotPasswordButton)),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    print(controller.loginForm.value);
                    print(controller.loginForm.valid);
                    goToRegister();
                  },
                  child: Text(AuthI10n.registerButton)),
              // SizedBox(
              //   height: 16,
              // ),
              // Divider(),
              // SizedBox(
              //   height: 16,
              // ),
              // Text('Autenticação via Google'),
              // SizedBox(
              //   height: 8,
              // ),
              // ElevatedButton(onPressed: () {}, child: Text('Google'))
            ],
          ),
        ),
      ),
    );
  }
}
