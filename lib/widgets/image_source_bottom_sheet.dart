import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final String title;
  final Function(ImageSource source) onImageSelected;
  final String? subtitle;

  const ImageSourceBottomSheet({
    super.key,
    required this.title,
    required this.onImageSelected,
    this.subtitle,
  });

  static void show({
    required BuildContext context,
    required String title,
    required Function(ImageSource source) onImageSelected,
    String? subtitle,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ImageSourceBottomSheet(
        title: title,
        onImageSelected: onImageSelected,
        subtitle: subtitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          
          // Title
          black18w500(data: title),
          if (subtitle != null) ...[
            SizedBox(height: 8.h),
            grey12(data: subtitle!, centre: true),
          ],
          SizedBox(height: 24.h),
          
          // Image source options
          Row(
            children: [
              Expanded(
                child: _buildSourceOption(
                  context: context,
                  title: 'Camera',
                  icon: Iconsax.camera,
                  onTap: () {
                    Navigator.pop(context);
                    onImageSelected(ImageSource.camera);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSourceOption(
                  context: context,
                  title: 'Gallery',
                  icon: Iconsax.gallery,
                  onTap: () {
                    Navigator.pop(context);
                    onImageSelected(ImageSource.gallery);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSourceOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: CustomColors.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: CustomColors.primaryColor,
            ),
            SizedBox(height: 8.h),
            black14w500(data: title),
          ],
        ),
      ),
    );
  }
}
