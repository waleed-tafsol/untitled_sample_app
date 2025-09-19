import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/custom_colors.dart';

class DriverPaymentScreen extends StatefulWidget {
  const DriverPaymentScreen({super.key});

  @override
  State<DriverPaymentScreen> createState() => _DriverPaymentScreenState();
}

class _DriverPaymentScreenState extends State<DriverPaymentScreen> {
  String _selectedPaymentMethod = 'bank_account';
  final _accountNumberController = TextEditingController();
  final _routingNumberController = TextEditingController();
  final _accountHolderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      Iconsax.card,
                      color: CustomColors.primaryColor,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Payment Method',
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
                  'Choose how you want to receive payments',
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
          
          // Payment Method Selection
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
                _buildPaymentMethodOption(
                  'Bank Account',
                  'Direct deposit to your bank account',
                  Iconsax.bank,
                  'bank_account',
                ),
                SizedBox(height: 16.h),
                
                _buildPaymentMethodOption(
                  'PayPal',
                  'Receive payments via PayPal',
                  Iconsax.card,
                  'paypal',
                ),
                SizedBox(height: 16.h),
                
                _buildPaymentMethodOption(
                  'Stripe',
                  'Secure payment processing with Stripe',
                  Iconsax.wallet_3,
                  'stripe',
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Payment Details Form
          if (_selectedPaymentMethod == 'bank_account') _buildBankAccountForm(),
          if (_selectedPaymentMethod == 'paypal') _buildPayPalForm(),
          if (_selectedPaymentMethod == 'stripe') _buildStripeForm(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(
    String title,
    String subtitle,
    IconData icon,
    String value,
  ) {
    final isSelected = _selectedPaymentMethod == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isSelected 
                    ? CustomColors.primaryColor 
                    : CustomColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isSelected 
                    ? CustomColors.whiteColor 
                    : CustomColors.primaryColor,
                size: 24.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? CustomColors.primaryColor 
                          : CustomColors.blackColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Iconsax.tick_circle,
                color: CustomColors.primaryColor,
                size: 20.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccountForm() {
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
            'Bank Account Details',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 20.h),
          _buildInputField(
            'Account Holder Name',
            'Enter account holder name',
            _accountHolderNameController,
            icon: Iconsax.user,
          ),
          SizedBox(height: 20.h),
          _buildInputField(
            'Account Number',
            'Enter your account number',
            _accountNumberController,
            keyboardType: TextInputType.number,
            icon: Iconsax.card,
          ),
          SizedBox(height: 20.h),
          _buildInputField(
            'Routing Number',
            'Enter your routing number',
            _routingNumberController,
            keyboardType: TextInputType.number,
            icon: Iconsax.bank,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.shield_tick,
                  color: CustomColors.primaryColor,
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Your bank account information is encrypted and secure',
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayPalForm() {
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
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Iconsax.card,
                  size: 48.w,
                  color: CustomColors.primaryColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  'PayPal Integration',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.blackColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'You will be redirected to PayPal to connect your account securely',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        // Handle PayPal connection
                      },
                      child: Center(
                        child: Text(
                          'Connect PayPal',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStripeForm() {
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
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Iconsax.wallet_3,
                  size: 48.w,
                  color: CustomColors.primaryColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Stripe Integration',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.blackColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Connect with Stripe for secure payment processing and instant payouts',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        // Handle Stripe connection
                      },
                      child: Center(
                        child: Text(
                          'Connect Stripe',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
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

  // Getters for accessing form data
  Map<String, String> getFormData() {
    return {
      'method': _selectedPaymentMethod,
      'accountHolderName': _accountHolderNameController.text,
      'accountNumber': _accountNumberController.text,
      'routingNumber': _routingNumberController.text,
    };
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _routingNumberController.dispose();
    _accountHolderNameController.dispose();
    super.dispose();
  }
}