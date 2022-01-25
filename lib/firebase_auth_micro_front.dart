import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'exports.dart';

class FirebaseAuthMicroFront {
  Page page(
      {required String name,
      required dynamic Function() onAfterLogin,
      Function()? onExit}) {
    return GetPage(
        name: name,
        page: () => AuthView(
              onAfterLogin: onAfterLogin,
              onExit: onExit,
            ),
        binding: AuthBindings());
  }
}
