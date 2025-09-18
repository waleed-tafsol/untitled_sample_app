import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose how you want to receive payments',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),
          
          // Payment Method Selection
          _buildPaymentMethodOption(
            'Bank Account',
            'Direct deposit to your bank account',
            Icons.account_balance,
            'bank_account',
          ),
          SizedBox(height: 16.h),
          
          _buildPaymentMethodOption(
            'PayPal',
            'Receive payments via PayPal',
            Icons.payment,
            'paypal',
          ),
          SizedBox(height: 16.h),
          
          _buildPaymentMethodOption(
            'Stripe',
            'Secure payment processing with Stripe',
            Icons.account_balance_wallet,
            'stripe',
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
            color: isSelected ? CustomColors.primaryColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? CustomColors.primaryColor.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isSelected ? CustomColors.primaryColor : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? CustomColors.primaryColor : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: CustomColors.primaryColor,
                size: 20.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccountForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Account Details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          'Account Holder Name',
          'Enter account holder name',
          _accountHolderNameController,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          'Account Number',
          'Enter your account number',
          _accountNumberController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          'Routing Number',
          'Enter your routing number',
          _routingNumberController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.blue.shade600,
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Your bank account information is encrypted and secure',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPayPalForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(
                Icons.payment,
                size: 48.w,
                color: Colors.blue.shade600,
              ),
              SizedBox(height: 16.h),
              Text(
                'PayPal Integration',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'You will be redirected to PayPal to connect your account securely',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  // Handle PayPal connection
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('Connect PayPal'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStripeForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Column(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 48.w,
                color: Colors.purple.shade600,
              ),
              SizedBox(height: 16.h),
              Text(
                'Stripe Integration',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade800,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Connect with Stripe for secure payment processing and instant payouts',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.purple.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  // Handle Stripe connection
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('Connect Stripe'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
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
              borderSide: BorderSide(color: CustomColors.primaryColor),
            ),
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
