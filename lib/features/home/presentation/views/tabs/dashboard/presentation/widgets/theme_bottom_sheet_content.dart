import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly_admin/core/components/custom_button.dart';
import 'package:taskly_admin/core/utils/colors_manger.dart';

class ThemeBottomSheetContent extends StatefulWidget {
  final String? initialTheme;

  const ThemeBottomSheetContent({super.key, this.initialTheme});

  @override
  State<ThemeBottomSheetContent> createState() =>
      _ThemeBottomSheetContentState();
}

class _ThemeBottomSheetContentState extends State<ThemeBottomSheetContent> {
  String? _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialTheme ?? "System Default";
  }

  @override
  Widget build(BuildContext context) {
    final themes = [
      {"title": "Light", "icon": Icons.light_mode},
      {"title": "Dark", "icon": Icons.dark_mode},
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(12.w),
            itemCount: themes.length,
            separatorBuilder:
                (_, __) => Divider(color: Colors.grey, thickness: 0.5),
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = theme["title"] == _selectedTheme;

              return ListTile(
                leading: Icon(
                  theme["icon"] as IconData,
                  color: ColorsManager.primary,
                ),
                title: Text(
                  theme["title"] as String,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: ColorsManager.black,fontSize: 16.sp,),
                ),
                trailing: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorsManager.black, width: 2),
                    color:
                        isSelected ? ColorsManager.primary : Colors.transparent,
                  ),
                  child:
                      isSelected
                          ? Icon(
                            Icons.done,
                            color: ColorsManager.white,
                            size: 16.sp,
                          )
                          : null,
                ),
                onTap: () {
                  setState(() {
                    _selectedTheme = theme["title"] as String;
                  });
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              title: "Save",
              ontap: () {
                if (_selectedTheme != null) {
                  Navigator.pop(context, _selectedTheme);
                }
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
