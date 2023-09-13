import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../Core/utils/color.dart';
import '../../../../../Core/utils/text_style.dart';

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
          color: Get.isDarkMode
              ? Colors.black
              : Colors.white, // Set the background color to white
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? const Color.fromARGB(255, 63, 63, 63)
                  : const Color(0xFFd9d9d9),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: validator,
          obscureText: visible ?? false,
          inputFormatters: inputFormat != null ? [inputFormat!] : null,
          onChanged: onChanged,
          decoration: InputDecoration(
              suffixIconColor: MyColors.gray,
              suffixIcon: GestureDetector(
                onTap: onTapSuffix,
                child: Icon(suffixicon, color: suffixcolor),
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: hinttext),
        ),
      ),
    );
  }
}
