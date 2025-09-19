import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/custom_colors.dart';

class DriverVehicleScreen extends StatefulWidget {
  const DriverVehicleScreen({super.key});

  @override
  State<DriverVehicleScreen> createState() => _DriverVehicleScreenState();
}

class _DriverVehicleScreenState extends State<DriverVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _seatingCapacityController = TextEditingController();
  String _selectedVehicleType = 'sedan';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: CustomColors.primaryColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.car,
                        color: CustomColors.primaryColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Vehicle Information',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please provide details about your vehicle',
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Form Section
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: CustomColors.primaryColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildInputField(
                    'Vehicle Make',
                    'e.g., Toyota, Honda, Ford',
                    _makeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter vehicle make';
                      }
                      return null;
                    },
                    icon: Iconsax.car,
                  ),
                  SizedBox(height: 20.h),
                  
                  _buildInputField(
                    'Vehicle Model',
                    'e.g., Camry, Civic, Focus',
                    _modelController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter vehicle model';
                      }
                      return null;
                    },
                    icon: Iconsax.car,
                  ),
                  SizedBox(height: 20.h),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          'Year',
                          'e.g., 2020',
                          _yearController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter vehicle year';
                            }
                            final year = int.tryParse(value);
                            if (year == null || year < 2000 || year > DateTime.now().year + 1) {
                              return 'Please enter a valid year';
                            }
                            return null;
                          },
                          icon: Iconsax.calendar,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInputField(
                          'Color',
                          'e.g., White, Black',
                          _colorController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter vehicle color';
                            }
                            return null;
                          },
                          icon: Iconsax.colorfilter,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          'License Plate',
                          'e.g., ABC-123',
                          _licensePlateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter license plate';
                            }
                            return null;
                          },
                          icon: Iconsax.card,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInputField(
                          'Seating Capacity',
                          'e.g., 4',
                          _seatingCapacityController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter seating capacity';
                            }
                            final capacity = int.tryParse(value);
                            if (capacity == null || capacity < 2 || capacity > 8) {
                              return 'Please enter a valid seating capacity (2-8)';
                            }
                            return null;
                          },
                          icon: Iconsax.people,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Vehicle Type Selection
            _buildVehicleTypeSection(),
            SizedBox(height: 24.h),
            
            // Additional Features
            _buildAdditionalFeaturesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.blackColor,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            color: CustomColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: CustomColors.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: CustomColors.primaryColor,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            prefixIcon: icon != null
                ? Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Icon(
                      icon,
                      color: CustomColors.primaryColor,
                      size: 20.sp,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleTypeSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Type',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildVehicleTypeOption('Sedan', Iconsax.car, 'sedan'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildVehicleTypeOption('SUV', Iconsax.car, 'suv'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildVehicleTypeOption('Hatchback', Iconsax.car, 'hatchback'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildVehicleTypeOption('Van', Iconsax.truck, 'van'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypeOption(String title, IconData icon, String value) {
    final isSelected = _selectedVehicleType == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicleType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected 
                ? CustomColors.primaryColor 
                : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected 
              ? CustomColors.primaryColor.withValues(alpha: 0.1) 
              : CustomColors.whiteColor,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? CustomColors.primaryColor 
                  : CustomColors.blackColor.withValues(alpha: 0.6),
              size: 32.w,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected 
                    ? CustomColors.primaryColor 
                    : CustomColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalFeaturesSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Features',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildFeatureOption('Air Conditioning', true),
          _buildFeatureOption('GPS Navigation', true),
          _buildFeatureOption('Bluetooth', false),
          _buildFeatureOption('USB Charging', true),
          _buildFeatureOption('Child Safety Seat', false),
          _buildFeatureOption('Wheelchair Accessible', false),
        ],
      ),
    );
  }

  Widget _buildFeatureOption(String title, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              // Handle feature selection
            },
            activeColor: CustomColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  // Getters for accessing form data
  Map<String, String> getFormData() {
    return {
      'make': _makeController.text,
      'model': _modelController.text,
      'year': _yearController.text,
      'color': _colorController.text,
      'licensePlate': _licensePlateController.text,
      'seatingCapacity': _seatingCapacityController.text,
      'vehicleType': _selectedVehicleType,
    };
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _licensePlateController.dispose();
    _seatingCapacityController.dispose();
    super.dispose();
  }
}