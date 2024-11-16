import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.searchController,
    required this.hintText,
  });

  final TextEditingController searchController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: backgroundBlack,),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: backgroundBlack,width: 1, style:
              BorderStyle.solid,)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: backgroundBlack,width: 1, style:
              BorderStyle.solid,)
          ),
          hintText: hintText
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
    );
  }
}
