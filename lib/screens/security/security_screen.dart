import 'package:flutter/material.dart';

import '../../data/local/storage_repository.dart';
import '../local_auth/first_method/confirm_pin_screen.dart';
import 'global_button_security.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
  });

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            SecurityButton(
                isEnabled: StorageRepository.getBool(key: 'biometrics'),
                onTab: () async {
                  bool isEnabled=StorageRepository.getBool(key: 'biometrics');
                  if(isEnabled){
                    await StorageRepository.setBool(key: 'biometrics', value:false);
                  }
                  else{
                    bool authenticated =
                    await BiometricAuthService.authenticate();
                    if (authenticated) {
                      await StorageRepository.setBool(
                          key: 'biometrics', value: true);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Boimetrics saved")));
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Boimetrics Error")));
                    }
                    if (!context.mounted) return;
                  }
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}