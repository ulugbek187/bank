import 'package:flutter/material.dart';
import '../../../data/local/storage_repository.dart';
import '../../screens/routes.dart';
import '../confirm_pin_screen.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Touch id"),
      ),
      body: Column(
        children: [
          const Icon(
            Icons.fingerprint_outlined,
            size: 100,
            color: Colors.blueAccent,
          ),
          TextButton(
            onPressed: enableBiometrics,
            child: const Text("Biometrics Auth"),
          ),
          TextButton(
              child: const Text("Skip"),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.tabRoute, (route) => false);
              })
        ],
      ),
    );
  }

  Future<void> enableBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(key: "biometrics_enabled", value: true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Biometrics Enabled"),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Biometrics Error"),
          ),
        );
      }
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.tabRoute, (route) => false);
    }
  }
}
