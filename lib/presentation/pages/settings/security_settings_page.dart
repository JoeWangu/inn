import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/security_controller.dart';

class SecuritySettingsPage extends ConsumerStatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  ConsumerState<SecuritySettingsPage> createState() =>
      _SecuritySettingsPAGEState();
}

class _SecuritySettingsPAGEState extends ConsumerState<SecuritySettingsPage> {
  @override
  Widget build(BuildContext context) {
    final securityState = ref.watch(securityControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: securityState.when(
        data: (state) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Enable PIN'),
                subtitle: const Text('Protect your app with a 4-digit PIN'),
                value: state.isPinEnabled,
                onChanged: (value) {
                  if (value) {
                    _showPinSetupDialog(context);
                  } else {
                    ref.read(securityControllerProvider.notifier).disablePin();
                  }
                },
              ),
              if (state.isPinEnabled) ...[
                const Divider(),
                if (state.isSupported)
                  SwitchListTile(
                    title: const Text('Enable Biometrics'),
                    subtitle: const Text('Use Fingerprint or Face ID'),
                    value: state.isBiometricsEnabled,
                    onChanged: (value) async {
                      if (value) {
                        // Verify biometrics can be used before enabling
                        final success = await ref
                            .read(securityControllerProvider.notifier)
                            .authenticateBiometrics();
                        if (success) {
                          ref
                              .read(securityControllerProvider.notifier)
                              .toggleBiometrics(true);
                        } else {
                          // If verification fails, don't enable biometrics
                          // The toggle will remain false
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Biometric verification failed. Please try again.'),
                            ),
                          );
                        }
                      } else {
                        ref
                            .read(securityControllerProvider.notifier)
                            .toggleBiometrics(false);
                      }
                    },
                  ),
                ListTile(
                  title: const Text('Change PIN'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showChangePinDialog(context),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Auto-Lock Timeout'),
                  subtitle: Text(state.autoLockTimeout.label),
                  trailing: DropdownButton<AutoLockTimeout>(
                    value: state.autoLockTimeout,
                    underline: const SizedBox(),
                    onChanged: (AutoLockTimeout? newValue) {
                      if (newValue != null) {
                        ref
                            .read(securityControllerProvider.notifier)
                            .setAutoLockTimeout(newValue);
                      }
                    },
                    items: AutoLockTimeout.values.map((AutoLockTimeout value) {
                      return DropdownMenuItem<AutoLockTimeout>(
                        value: value,
                        child: Text(value.label),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showPinSetupDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const PinSetupDialog());
  }

  void _showChangePinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PinSetupDialog(isChangePin: true),
    );
  }
}

class PinSetupDialog extends ConsumerStatefulWidget {
  final bool isChangePin;
  const PinSetupDialog({super.key, this.isChangePin = false});

  @override
  ConsumerState<PinSetupDialog> createState() => _PinSetupDialogState();
}

class _PinSetupDialogState extends ConsumerState<PinSetupDialog> {
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _verifyingOldPin = false; // For change PIN flow
  String _error = '';

  @override
  void initState() {
    super.initState();
    if (widget.isChangePin) {
      _verifyingOldPin = true;
    }
  }

  void _onNumberTap(String number) {
    setState(() {
      _error = '';
      if (_verifyingOldPin) {
        if (_pin.length < 4) _pin += number;
        if (_pin.length == 4) _verifyOldPin();
      } else if (!_isConfirming) {
        if (_pin.length < 4) _pin += number;
        if (_pin.length == 4) {
          _isConfirming = true;
        }
      } else {
        if (_confirmPin.length < 4) _confirmPin += number;
        if (_confirmPin.length == 4) _finalizePin();
      }
    });
  }

  void _onBackspace() {
    setState(() {
      _error = '';
      if (_verifyingOldPin) {
        if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
      } else if (!_isConfirming) {
        if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
      } else {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          _isConfirming = false;
          _pin = '';
        }
      }
    });
  }

  Future<void> _verifyOldPin() async {
    final success = await ref
        .read(securityControllerProvider.notifier)
        .verifyPin(_pin);
    if (success) {
      setState(() {
        _verifyingOldPin = false;
        _pin = '';
        _error = '';
      });
    } else {
      setState(() {
        _pin = '';
        _error = 'Incorrect PIN';
      });
    }
  }

  void _finalizePin() {
    if (_pin == _confirmPin) {
      ref.read(securityControllerProvider.notifier).setPin(_pin);
      Navigator.of(context).pop();
    } else {
      setState(() {
        _error = 'PINs do not match';
        _confirmPin = '';
        _pin = '';
        _isConfirming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (_verifyingOldPin) {
      title = 'Enter Old PIN';
    } else if (!_isConfirming) {
      title = widget.isChangePin ? 'Enter New PIN' : 'Create PIN';
    } else {
      title = 'Confirm PIN';
    }

    String displayPin = _verifyingOldPin
        ? _pin
        : (!_isConfirming ? _pin : _confirmPin);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        height: 450,
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < displayPin.length
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(_error, style: const TextStyle(color: Colors.red)),
              ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var j = 1; j <= 3; j++) _buildKey('${i * 3 + j}'),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 60),
              _buildKey('0'),
              SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                  onPressed: _onBackspace,
                  icon: const Icon(Icons.backspace_outlined),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKey(String number) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextButton(
        onPressed: () => _onNumberTap(number),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.grey.shade100,
        ),
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
