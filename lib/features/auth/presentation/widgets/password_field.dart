import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final Function(String) onChanged;

  const PasswordField({super.key, required this.onChanged});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
