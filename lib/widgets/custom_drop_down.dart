import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String selectedMonth;
  final Function(String? value) onChanged;
  final List<String> items;
  final double width;
  const CustomDropDown({
    super.key,
    required this.selectedMonth,
    required this.onChanged,
    required this.items,
    required this.width,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      customButton: Container(
        height: 30,
        width: widget.width,
        decoration: BoxDecoration(
          color: AppColors.primary100,
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.20)),
          ],
        ),
        child: Row(
          children: [
            const Spacer(),
            Center(
              child: Text(
                widget.selectedMonth,
                style: MyAppTypography.body2.copyWith(color: AppColors.bg100),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
      onChanged: (value) => widget.onChanged.call(value),
      value: widget.selectedMonth,
      alignment: Alignment.centerRight,
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: AppColors.bg200,
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        selectedMenuItemBuilder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.selectedMonth,
                style: MyAppTypography.body2.copyWith(color: AppColors.bg100),
              ),
            ),
          );
        },
      ),
      underline: const SizedBox(),
      items: List.generate(
        widget.items.length,
        (index) => DropdownMenuItem(
          alignment: Alignment.center,
          value: widget.items[index],
          child: Text(
            widget.items[index],
          ),
        ),
      ),
      style: MyAppTypography.body2,
    );
  }
}
