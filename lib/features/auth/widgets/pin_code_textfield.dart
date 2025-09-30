import 'package:driveprep/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PinCodeTextField extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;

  const PinCodeTextField({
    super.key,
    required this.length,
    required this.onCompleted,
  });

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers = List.generate(widget.length, (index) => TextEditingController());

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < widget.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        if (_controllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
        String pin = _controllers.map((e) => e.text).join();
        if (pin.length == widget.length) {
          widget.onCompleted(pin);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 56,
          height: 56,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: true,
            style: AppTextStyles.interStyle(
              weight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE3E3E9)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE3E3E9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF1B6EF7)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
