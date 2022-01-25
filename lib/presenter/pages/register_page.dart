import 'package:firebase_authentication_microfront/presenter/pages/components/warn_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../exports.dart';

class RegisterPager extends GetView<AuthController> {
  final Function() onRegister;
  final Function() onBack;

  RegisterPager({required this.onRegister, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: controller.registerForm,
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              AppInfoMedia(
                visible: false,
              ),
              Text(AuthI10n.registerTitle),
              SizedBox(
                height: 16,
              ),
              ReactiveTextField(
                formControlName: AuthFields.email,
                validationMessages: (control) => {
                  ValidationMessage.required: AuthI10n.emailRequired,
                  ValidationMessage.email: AuthI10n.emailInvalid,
                },
                decoration: InputDecoration(
                    hintText: AuthI10n.emailPlaceholder,
                    label: Text(AuthI10n.emailLabel)),
              ),
              ReactiveTextField(
                formControlName: AuthFields.password,
                validationMessages: (control) => {
                  ValidationMessage.required: AuthI10n.passwordRequired,
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: AuthI10n.passwordPlaceholder,
                    label: Text(AuthI10n.passwordLabel)),
              ),
              ReactiveTextField(
                formControlName: AuthFields.passwordConfirmation,
                validationMessages: (control) => {
                  ValidationMessage.required:
                      AuthI10n.passwordConfirmationRequired,
                  ValidationMessage.mustMatch:
                      AuthI10n.passwordConfirmationMismatch
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: AuthI10n.passwordConfirmationPlaceholder,
                    label: Text(AuthI10n.passwordConfirmationLabel)),
              ),
              SizedBox(
                height: 8,
              ),
              Obx(() => WarnInfo(
                    visible: controller.registerErrorMessage.value.isNotEmpty,
                    text: controller.registerErrorMessage.value,
                  )),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: onRegister, child: Text(AuthI10n.saveButton)),
              SizedBox(
                height: 8,
              ),
              TextButton(onPressed: onBack, child: Text(AuthI10n.backButton)),
            ],
          ),
        ),
      ),
    );
  }
}
