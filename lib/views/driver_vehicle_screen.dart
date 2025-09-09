import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Information',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please provide details about your vehicle',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 24.h),
            
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
            ),
            SizedBox(height: 16.h),
            
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
            ),
            SizedBox(height: 16.h),
            
            _buildInputField(
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
            ),
            SizedBox(height: 16.h),
            
            _buildInputField(
              'Color',
              'e.g., White, Black, Silver',
              _colorController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle color';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            
            _buildInputField(
              'License Plate',
              'e.g., ABC-123',
              _licensePlateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter license plate';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            
            _buildInputField(
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: CustomColors.purpleColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildVehicleTypeOption('Sedan', Icons.directions_car, true),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildVehicleTypeOption('SUV', Icons.directions_car, false),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildVehicleTypeOption('Hatchback', Icons.directions_car, false),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildVehicleTypeOption('Van', Icons.airport_shuttle, false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypeOption(String title, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle vehicle type selection
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? CustomColors.purpleColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? CustomColors.purpleColor.withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? CustomColors.purpleColor : Colors.grey.shade600,
              size: 32.w,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? CustomColors.purpleColor : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Features',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        _buildFeatureOption('Air Conditioning', true),
        _buildFeatureOption('GPS Navigation', true),
        _buildFeatureOption('Bluetooth', false),
        _buildFeatureOption('USB Charging', true),
        _buildFeatureOption('Child Safety Seat', false),
        _buildFeatureOption('Wheelchair Accessible', false),
      ],
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
            activeColor: CustomColors.purpleColor,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
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
