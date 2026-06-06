import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/api_service.dart';
import '../providers/auth_provider.dart';

class InterestSetupScreen extends ConsumerStatefulWidget {
  const InterestSetupScreen({super.key});

  @override
  ConsumerState<InterestSetupScreen> createState() =>
      _InterestSetupScreenState();
}

class _InterestSetupScreenState extends ConsumerState<InterestSetupScreen> {
  final Set<String> _selected = {};

  Future<void> _save() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih minimal satu minat')),
      );
      return;
    }

    try {
      await ref.read(apiServiceProvider).updateProfile({
        'interests': _selected.toList(),
      });
    } catch (_) {
      // Continue even if API fails (offline dev)
    }

    await ref.read(authStorageProvider).setInterestsSetupComplete(true);
    if (mounted) context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Apa minat alammu?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepForest,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori yang kamu sukai untuk personalisasi feed.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: interestOptions.map((interest) {
                    final selected = _selected.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) {
                            _selected.add(interest);
                          } else {
                            _selected.remove(interest);
                          }
                        });
                      },
                      selectedColor: AppColors.forestGreen,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Lanjutkan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
