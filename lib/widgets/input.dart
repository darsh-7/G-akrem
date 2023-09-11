import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final bool enabled;
  final String? label;
  final double? bottomPadding;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.bottomPadding = 8,
    this.onEditingComplete,
    this.enabled = true,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.width,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      _obscure = true;
    }
  }

  //double _radius = 0;

  //
  // void setRadius(double value) {
  //   setState(() {
  //     _radius = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var defaultBorder =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.blue));
    return Container(
      //height: 20.0,
      width: widget.width,
      // decoration: BoxDecoration(
      //   color: Color(0xFFf1f0f5),
      //   borderRadius: BorderRadius.circular(_radius),
      // ),
      padding: EdgeInsets.only(bottom: widget.bottomPadding ?? 0),
      child: TextFormField(
        // onTap: () => setRadius(24.0),
        // onTapOutside: (PointerDownEvent) => setRadius(0.0),
        onChanged: widget.onChanged,
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        onEditingComplete: widget.onEditingComplete,
        inputFormatters: widget.inputFormatters,

        obscuringCharacter: '*',
        validator: widget.validator,
        decoration: InputDecoration(
          enabled: widget.enabled,
          border: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(0.0),
          ),
          focusedBorder: defaultBorder.copyWith(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: AppColors.mainColor,
            ),
          ),
          errorBorder: defaultBorder.copyWith(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.red),
          ),
          disabledBorder: defaultBorder.copyWith(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: AppColors.mainColor,
              )),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          label: Text(widget.label ?? ""),
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(64),
                      child: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool? value) onChanged;
  final String? labelText;
  final Widget? label;

  const CustomCheckbox({
    this.value = false,
    required this.onChanged,
    this.labelText,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        if (labelText != null)
          GestureDetector(
            child: Text(labelText!),
            onTap: () => onChanged(!value),
          )
        else if (label != null)
          GestureDetector(
            child: label,
            onTap: () => onChanged(!value),
          )
      ],
    );
  }
}
