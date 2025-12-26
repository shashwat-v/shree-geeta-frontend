import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';
import 'package:shree_geeta/components/social_button.dart';

class SignUpScreen
    extends
        StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<
    SignUpScreen
  >
  createState() => _SignUpScreenState();
}

class _SignUpScreenState
    extends
        State<
          SignUpScreen
        > {
  final _formKey =
      GlobalKey<
        FormState
      >();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<
    void
  >
  _handleSignUp() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check password match
    if (_passwordController.text !=
        _confirmPasswordController.text) {
      _showErrorSnackBar(
        'Passwords do not match',
      );
      return;
    }

    FocusScope.of(
      context,
    ).unfocus();

    setState(
      () => _isLoading = true,
    );

    try {
      final authProvider = context
          .read<
            AuthProvider
          >();

      final success = await authProvider.signup(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        // Signup successful - navigate to home
        Navigator.pushReplacementNamed(
          context,
          '/home',
        );
      } else {
        // Show error message
        _showErrorSnackBar(
          authProvider.error ??
              'Sign up failed. Please try again.',
        );
      }
    } catch (
      e
    ) {
      if (mounted) {
        _showErrorSnackBar(
          'An unexpected error occurred',
        );
      }
    } finally {
      if (mounted) {
        setState(
          () => _isLoading = false,
        );
      }
    }
  }

  void _showErrorSnackBar(
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        margin: const EdgeInsets.all(
          16,
        ),
      ),
    );
  }

  void _showSuccessSnackBar(
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        margin: const EdgeInsets.all(
          16,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF3F3F3,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder:
              (
                context,
                constraints,
              ) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).maybePop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                              splashRadius: 22,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).maybePop();
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                              ),
                              splashRadius: 22,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 480,
                            ),
                            padding: const EdgeInsets.fromLTRB(
                              24,
                              28,
                              24,
                              24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                28,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(
                                    0x1A000000,
                                  ),
                                  blurRadius: 24,
                                  offset: Offset(
                                    0,
                                    16,
                                  ),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children:
                                    <
                                      Widget
                                    >[
                                      Column(
                                        children: [
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                0.11,
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.menu_book_rounded,
                                                color: Color.fromRGBO(
                                                  254,
                                                  153,
                                                  51,
                                                  1,
                                                ),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const Text(
                                            'Create your account',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Join Shree Geeta and explore guidance inspired by the Bhagavad Gita.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        'Full Name',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _nameController,
                                        textInputAction: TextInputAction.next,
                                        textCapitalization: TextCapitalization.words,
                                        enabled: !_isLoading,
                                        decoration: InputDecoration(
                                          hintText: 'Shree Krishna',
                                          prefixIcon: const Icon(
                                            Icons.person_outline_rounded,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                1,
                                              ),
                                              width: 1.4,
                                            ),
                                          ),
                                          errorStyle: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        validator:
                                            (
                                              value,
                                            ) {
                                              if (value ==
                                                      null ||
                                                  value.trim().isEmpty) {
                                                return 'Please enter your name';
                                              }
                                              if (value.trim().length <
                                                  2) {
                                                return 'Name must be at least 2 characters';
                                              }
                                              return null;
                                            },
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        'Email address',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        enabled: !_isLoading,
                                        decoration: InputDecoration(
                                          hintText: '12345678@gmail.com',
                                          prefixIcon: const Icon(
                                            Icons.alternate_email_rounded,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                1,
                                              ),
                                              width: 1.4,
                                            ),
                                          ),
                                          errorStyle: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        validator:
                                            (
                                              value,
                                            ) {
                                              if (value ==
                                                      null ||
                                                  value.trim().isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!value.contains(
                                                    '@',
                                                  ) ||
                                                  !value.contains(
                                                    '.',
                                                  )) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
                                            },
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _usernameController,
                                        textInputAction: TextInputAction.next,
                                        enabled: !_isLoading,
                                        decoration: InputDecoration(
                                          hintText: 'krishna_devotee',
                                          prefixIcon: const Icon(
                                            Icons.account_circle_outlined,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                1,
                                              ),
                                              width: 1.4,
                                            ),
                                          ),
                                          errorStyle: const TextStyle(
                                            fontSize: 11,
                                          ),
                                          helperText: 'No spaces, min 3 characters',
                                          helperStyle: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        validator:
                                            (
                                              value,
                                            ) {
                                              if (value ==
                                                      null ||
                                                  value.trim().isEmpty) {
                                                return 'Please enter a username';
                                              }
                                              if (value.trim().length <
                                                  3) {
                                                return 'Username must be at least 3 characters';
                                              }
                                              if (value.contains(
                                                ' ',
                                              )) {
                                                return 'Username cannot contain spaces';
                                              }
                                              return null;
                                            },
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        textInputAction: TextInputAction.next,
                                        enabled: !_isLoading,
                                        decoration: InputDecoration(
                                          hintText: '••••••••••••••••',
                                          prefixIcon: const Icon(
                                            Icons.lock_outline_rounded,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _obscurePassword = !_obscurePassword;
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                1,
                                              ),
                                              width: 1.4,
                                            ),
                                          ),
                                          errorStyle: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        validator:
                                            (
                                              value,
                                            ) {
                                              if (value ==
                                                      null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (value.length <
                                                  6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        'Confirm password',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: _obscureConfirm,
                                        textInputAction: TextInputAction.done,
                                        enabled: !_isLoading,
                                        onFieldSubmitted:
                                            (
                                              _,
                                            ) => _handleSignUp(),
                                        decoration: InputDecoration(
                                          hintText: '••••••••••••••••',
                                          prefixIcon: const Icon(
                                            Icons.lock_outline_rounded,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _obscureConfirm = !_obscureConfirm;
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              _obscureConfirm
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                254,
                                                153,
                                                51,
                                                1,
                                              ),
                                              width: 1.4,
                                            ),
                                          ),
                                          errorStyle: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        validator:
                                            (
                                              value,
                                            ) {
                                              if (value ==
                                                      null ||
                                                  value.isEmpty) {
                                                return 'Please confirm your password';
                                              }
                                              return null;
                                            },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 52,
                                        child: ElevatedButton(
                                          onPressed: _isLoading
                                              ? null
                                              : _handleSignUp,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromRGBO(
                                              254,
                                              153,
                                              51,
                                              1,
                                            ),
                                            foregroundColor: Colors.white,
                                            disabledBackgroundColor: Colors.orange.shade200,
                                            disabledForegroundColor: Colors.white70,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                24,
                                              ),
                                            ),
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            elevation: 0,
                                          ),
                                          child: _isLoading
                                              ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                )
                                              : const Text(
                                                  'Continue',
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children:
                                            <
                                              Widget
                                            >[
                                              Expanded(
                                                child: Container(
                                                  height: 1,
                                                  color: const Color(
                                                    0xFFE9E9E9,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                child: Text(
                                                  'Or continue with',
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 1,
                                                  color: const Color(
                                                    0xFFE9E9E9,
                                                  ),
                                                ),
                                              ),
                                            ],
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Column(
                                        children: [
                                          SocialButton(
                                            label: 'Continue with Apple',
                                            icon: Icons.apple,
                                            onPressed: _isLoading
                                                ? null
                                                : () {
                                                    _showSuccessSnackBar(
                                                      'Apple Sign Up coming soon!',
                                                    );
                                                  },
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SocialButton(
                                            label: 'Continue with Google',
                                            icon: Icons.g_mobiledata_rounded,
                                            onPressed: _isLoading
                                                ? null
                                                : () {
                                                    _showSuccessSnackBar(
                                                      'Google Sign Up coming soon!',
                                                    );
                                                  },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                            <
                                              Widget
                                            >[
                                              const Text(
                                                "Already have an account?",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: _isLoading
                                                    ? null
                                                    : () {
                                                        Navigator.of(
                                                          context,
                                                        ).maybePop();
                                                      },
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  minimumSize: const Size(
                                                    0,
                                                    0,
                                                  ),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                child: const Text(
                                                  'Log in',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                      254,
                                                      153,
                                                      51,
                                                      1,
                                                    ),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ],
                                      ),
                                    ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'By continuing you agree to our Terms and Privacy Policy.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
        ),
      ),
    );
  }
}
