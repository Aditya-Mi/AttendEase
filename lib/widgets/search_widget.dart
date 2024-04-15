import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_shadow.dart';
import 'package:attendease/core/app_text.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String value) onChanged;
  final Function() onEditingComplete;
  const SearchWidget(
      {super.key, required this.onChanged, required this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: double.infinity,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          MyAppBoxShadow.myCustomBoxShadow(Colors.black.withOpacity(0.10)),
        ],
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.text100,
          ),
          hintText: 'Search here',
          hintStyle: MyAppTypography.body3
              .copyWith(color: AppColors.text200.withOpacity(0.5)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) => onChanged.call(value),
        onEditingComplete: () => onEditingComplete,
      ),
    );
  }
}
