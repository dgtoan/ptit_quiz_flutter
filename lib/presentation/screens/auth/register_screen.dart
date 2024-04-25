import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ptit_quiz_frontend/core/router/app_router.dart';
import 'package:ptit_quiz_frontend/domain/entities/account.dart';
import 'package:ptit_quiz_frontend/presentation/blocs/app_bloc.dart';
import 'package:ptit_quiz_frontend/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/app_loading_animation.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/app_text_field.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/devider_with_text.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/ptit_logo.dart';
import 'package:toastification/toastification.dart';

import '../../../core/utils/validator.dart';
import '../../../domain/entities/profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  String appTitle = 'Register to PTIT Quiz';
  bool _passwordVisible = false;
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  bool canRegister = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateError) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                style: ToastificationStyle.flatColored,
                title: const Text('Register failed'),
                description: Text(state.message),
                alignment: Alignment.topRight,
                autoCloseDuration: const Duration(seconds: 4),
              );
            } else if (
              state is AuthStateAuthenticated ||
              state is AuthStateAdminAuthenticated
            ) {
              context.go(AppRoutes.home);
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.flatColored,
                title: const Text('Register successfully'),
                description: const Text('Welcome to PTIT Quiz'),
                alignment: Alignment.topRight,
                autoCloseDuration: const Duration(seconds: 4),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 540,
                              minHeight: size.height
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                const SizedBox(height: 10),
                                const PtitLogo(),
                                const SizedBox(height: 24),
                                Text(
                                  appTitle,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                AppTextField(
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  labelText: 'Full Name',
                                  hintText: 'Duong Toan',
                                  errorText: nameError,
                                  prefixIconData: Icons.person_outline,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) {
                                    _nameFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_emailFocusNode);
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  labelText: 'Email',
                                  hintText: 'example@gmail.com',
                                  errorText: emailError,
                                  prefixIconData: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) {
                                    _emailFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  labelText: 'Password',
                                  hintText: '********',
                                  errorText: passwordError,
                                  prefixIconData: Icons.lock_outline,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                        ),
                                      onPressed: () {
                                        setState(() {
                                            _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !_passwordVisible,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) {
                                    _passwordFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_confirmPasswordFocusNode);
                                  },
                                ),
                                const SizedBox(height: 16),
                                AppTextField(
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,
                                  labelText: 'Confirm Password',
                                  hintText: '********',
                                  errorText: confirmPasswordError,
                                  prefixIconData: Icons.lock_outline,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) {
                                    _confirmPasswordFocusNode.unfocus();
                                    register();
                                  },
                                ),
                                const SizedBox(height: 20),
                                FilledButton(
                                  onPressed: () => {
                                    register()
                                  },
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const DeviderWithText(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Already have an account?'),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.go(AppRoutes.login);
                                        },
                                        child: Text(
                                          ' Login here',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is AuthStateLoading)
                  const AppLoadingAnimation(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    _nameController.addListener(() {
      setState(() {
        nameError = Validator.isName(_nameController.text);
        updateCanRegister();
      });
    });

    _emailController.addListener(() {
      setState(() {
        emailError = Validator.isEmail(_emailController.text);
        updateCanRegister();
      });
    });

    _passwordController.addListener(() {
      setState(() {
        passwordError = Validator.isPassword(_passwordController.text);
        updateCanRegister();
      });
    });

    _confirmPasswordController.addListener(() {
      setState(() {
        confirmPasswordError = Validator.isConfirmPassword(
          _passwordController.text,
          _confirmPasswordController.text,
        );
        updateCanRegister();
      });
    });
  }

  void updateCanRegister() {
    canRegister = nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void register() {
    if (canRegister) {
      context.read<AuthBloc>().add(
            AuthRegisterEvent(
              account: Account(
                email: _emailController.text,
                password: _passwordController.text,
              ),
              profile: Profile(
                fullName: _nameController.text,
                email: _emailController.text,
              ),
            ),
          );
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: const Text('Register failed'),
        description: const Text('Please fill in all fields correctly'),
        alignment: Alignment.topRight,
        autoCloseDuration: const Duration(seconds: 3),
        dragToClose: true,
      );
    }
  }
}