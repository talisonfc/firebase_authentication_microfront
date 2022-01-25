import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../exports.dart';

class AuthController extends GetxController {
  late FirebaseAuth firebaseAuth;

  final signInErrorMessage = ''.obs;
  final resetErrorMessage = ''.obs;
  final registerErrorMessage = ''.obs;

  final loginForm = FormGroup({
    AuthFields.email: FormControl(
        validators: [Validators.required, Validators.email]),
    AuthFields.password: FormControl(validators: [Validators.required])
  });

  final registerForm = FormGroup({
    AuthFields.email:
        FormControl(validators: [Validators.required, Validators.email]),
    AuthFields.password: FormControl(validators: [Validators.required]),
    AuthFields.passwordConfirmation:
        FormControl(validators: [Validators.required]),
  }, validators: [
    (control) {
      final form = control as FormGroup;

      final formControl = form.control(AuthFields.password);
      final matchingFormControl =
          form.control(AuthFields.passwordConfirmation);

      if(matchingFormControl.value == null || matchingFormControl.value.isEmpty){
        matchingFormControl.setErrors({ValidationMessage.required: true});
      }
      else if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({ValidationMessage.mustMatch: true});
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.removeError(ValidationMessage.required);
        matchingFormControl.removeError(ValidationMessage.mustMatch);
      }

      return null;
    }
  ]);

  final resetForm = FormGroup({
    AuthFields.email: FormControl(validators: [Validators.required, Validators.email])
  });

  @override
  void onInit() {
    super.onInit();

    firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.authStateChanges().listen((event) {
      print(event);
    }, onDone: () {
      print('done auth');
    }, onError: (error) {
      print(error);
    });
  }

  void signInWithEmailAndPassword(Function() onSuccess) {
    loginForm.markAllAsTouched();
    if (loginForm.valid) {
      final email = loginForm.control('email').value;
      final password = loginForm.control('password').value;
      firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredencial) {
        onSuccess();
      }).catchError((error) {
        final authException = error as FirebaseAuthException;
        signInErrorMessage.value = authException.message!;
      });
    }
  }

  void register(Function() onSuccess) {
    registerForm.markAllAsTouched();
    if (registerForm.valid) {
      final email = registerForm.control(AuthFields.email).value;
      final password = registerForm.control(AuthFields.password).value;
      firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredencial) {
        onSuccess();
      }).catchError((error) {
        final authException = error as FirebaseAuthException;
        registerErrorMessage.value = authException.message!;
      });
    }
  }

  void reset(Function() onSuccess) {
    resetForm.markAllAsTouched();
    if (resetForm.valid) {
      final email = resetForm.control(AuthFields.email).value;
      firebaseAuth.sendPasswordResetEmail(email: email).then((userCredencial) {
        onSuccess();
      }).catchError((error) {
        final authException = error as FirebaseAuthException;
        resetErrorMessage.value = authException.message!;
      });
    }
  }

  void signIn() {}
}
