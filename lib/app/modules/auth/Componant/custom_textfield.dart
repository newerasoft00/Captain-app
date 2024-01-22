import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.suffixicon,
    required this.hint,
    required this.onChanged,
    this.inputFormat,
    this.visible,
    this.onTapSuffix,
    required this.suffixcolor,
    this.validator,
  });
  final IconData suffixicon;
  final String hint;
  final void Function(String) onChanged;
  final TextInputFormatter? inputFormat;
  final bool? visible;
  final VoidCallback? onTapSuffix;
  final Color suffixcolor;
  final String? Function(String?)? validator;

  //final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          color: Theme.of(context).cardColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          validator: validator,
          obscureText: visible ?? false,
          inputFormatters: inputFormat != null ? [inputFormat!] : null,
          onChanged: onChanged,
          decoration: InputDecoration(
              suffixIconColor: Colors.grey,
              suffixIcon: GestureDetector(
                onTap: onTapSuffix,
                child: Icon(suffixicon, color: suffixcolor),
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Get.isDarkMode
                      ? Theme.of(context).hintColor
                      : Colors.black38)),
        ),
      ),
    );
  }
}
