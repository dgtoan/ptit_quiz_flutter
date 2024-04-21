import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String labelText;
  final String hintText;
  final String? errorText;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function(String)? onSubmitted;

  const AppTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.labelText,
    required this.hintText,
    this.errorText,
    this.prefixIconData,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(widget.prefixIconData),
        ),
        suffixIcon: widget.suffixIcon,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      onSubmitted: widget.onSubmitted,
    );
  }
}

// TextField(
//   controller: _emailController,
//   focusNode: _emailFocusNode,
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     labelText: 'Email',
//     hintText: 'example@gmail.com',
//     errorText: emailError.isEmpty ? null : emailError,
//     prefixIcon: const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Icon(Icons.email_outlined),
//     )
//   ),
//   keyboardType: TextInputType.emailAddress,
//   textInputAction: TextInputAction.next,
//   onSubmitted: (_) {
//     _emailFocusNode.unfocus();
//     FocusScope.of(context)
//         .requestFocus(_passwordFocusNode);
//   },
// ),
// const SizedBox(height: 16),
// TextField(
//   controller: _passwordController,
//   focusNode: _passwordFocusNode,
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     labelText: 'Password',
//     hintText: '********',
//     errorText:
//         passwordError.isEmpty ? null : passwordError,
//     prefixIcon: const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Icon(Icons.lock_outline),
//     ),
//     suffixIcon: Padding(
//       padding: const EdgeInsets.only(right: 12),
//       child: IconButton(
//         icon: Icon(
//           _passwordVisible
//           ? Icons.visibility
//           : Icons.visibility_off,
//           ),
//         onPressed: () {
//           setState(() {
//               _passwordVisible = !_passwordVisible;
//           });
//         },
//       ),
//     ),
//   ),
//   obscureText: !_passwordVisible,
//   textInputAction: TextInputAction.done,
//   onSubmitted: (_) {
//     _passwordFocusNode.unfocus();
//     login();
//   },
// ),