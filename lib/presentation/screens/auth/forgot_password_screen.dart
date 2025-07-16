import 'package:flowdeck/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flowdeck/core/constants/app_constants.dart';
import 'package:flowdeck/presentation/widgets/common/custom_text_field.dart';
import 'package:flowdeck/presentation/widgets/common/loading_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override 
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authViewModelProvider.notifier)
          .sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() => _emailSent = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: _emailSent ? _buildEmailSentContent() : _buildFormContent(),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppDimensions.xl),
          const Icon(
            Icons.lock_reset,
            size: AppDimensions.iconXl,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppDimensions.lg),
          Text(
            'Forgot Password?',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.sm),
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.xl),
          CustomTextField(
            controller: _emailController,
            label: AppStrings.email,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
            onSubmitted: (_) => _sendResetEmail(),
          ),
          const SizedBox(height: AppDimensions.lg),
          LoadingButton(
            onPressed: _sendResetEmail,
            isLoading: _isLoading,
            text: 'Send Reset Link',
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSentContent() {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: AppDimensions.xl),
        const Icon(
          Icons.mark_email_read,
          size: AppDimensions.iconXl,
          color: AppColors.success,
        ),
        const SizedBox(height: AppDimensions.lg),
        Text(
          'Email Sent!',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.sm),
        Text(
          'We\'ve sent a password reset link to ${_emailController.text}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.xl),
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Back to Sign In'),
        ),
        const SizedBox(height: AppDimensions.md),
        TextButton(
          onPressed: () {
            setState(() => _emailSent = false);
          },
          child: const Text('Send Again'),
        ),
      ],
    );
  }
}
