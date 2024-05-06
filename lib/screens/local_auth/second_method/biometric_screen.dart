import 'package:bank_app/bank_app.dart';
import 'package:flutter/material.dart';
import '../../../data/local/storage_repository.dart';
import '../../routes.dart';
import '../first_method/confirm_pin_screen.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, size: 150.w),
            TextButton(
                onPressed: enabledBio, child: const Text("Biometric auth")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.tabRoute, (route) => false);
                },
                child: const Text("skip"))
          ],
        ),
      ),
    );
  }

  Future<void> enabledBio() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(key: 'biometrics', value: true);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Biometrics saved")));
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.tabRoute,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Biometrics Error")));
      }
    }
  }
}
