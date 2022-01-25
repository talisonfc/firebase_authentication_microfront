import 'package:firebase_authentication_microfront/core/constants/exports.dart';
import 'package:firebase_authentication_microfront/presenter/pages/components/warn_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../exports.dart';

class ResetPasswordPage extends GetView<AuthController> {
  final Function() onSend;
  final Function() onBack;

  ResetPasswordPage({required this.onSend, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: controller.resetForm,
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              AppInfoMedia(
                visible: false,
              ),
              Text(AuthI10n.resetTitle),
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
              SizedBox(
                height: 8,
              ),
              Obx(() => WarnInfo(
                    text: controller.resetErrorMessage.value,
                    visible: controller.resetErrorMessage.value.isNotEmpty,
                  )),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: onSend, child: Text(AuthI10n.sendButton)),
              SizedBox(
                height: 8,
              ),
              TextButton(onPressed: onBack, child: Text(AuthI10n.backButton))
            ],
          ),
        ),
      ),
    );
  }
}
