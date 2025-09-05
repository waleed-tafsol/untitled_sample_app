# Phone Authentication App

A Flutter application that demonstrates phone number authentication with OTP verification using the MVVM design pattern and Provider for state management.

## Features

- **Login Screen**: Australian phone number validation and input
- **OTP Screen**: 6-digit OTP verification with resend functionality
- **Success Screen**: Confirmation of successful verification
- **MVVM Architecture**: Clean separation of concerns
- **Provider State Management**: Reactive state management
- **Modern UI**: Beautiful and responsive design

## Architecture

The app follows the MVVM (Model-View-ViewModel) design pattern:

### Models
- `UserModel`: Represents user data (phone number, OTP, verification status)
- `AuthStateModel`: Manages authentication state and error handling

### ViewModels
- `AuthViewModel`: Handles business logic, validation, and state management

### Views
- `LoginScreen`: Phone number input with Australian validation
- `OtpScreen`: OTP input with resend timer functionality
- `SuccessScreen`: Verification success confirmation

### Services
- `AuthService`: Simulates API calls for OTP sending and verification

## Dependencies

- `provider: ^6.1.2` - State management
- `intl_phone_field: ^3.2.0` - International phone number input
- `pin_code_fields: ^8.0.1` - OTP input field

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Usage

1. **Login Screen**: Enter a valid Australian phone number (format: +61 X XXXX XXXX)
2. **OTP Screen**: Enter the 6-digit OTP code (any 6-digit number for demo purposes)
3. **Success Screen**: View confirmation and option to continue or sign out

## Phone Number Validation

The app validates Australian phone numbers using the regex pattern: `^\+61[2-9]\d{8}$`

This ensures:
- Country code: +61
- Area code: 2-9 (valid Australian area codes)
- Phone number: 8 digits

## Demo Mode

The app runs in demo mode where:
- Any valid Australian phone number format is accepted
- Any 6-digit OTP is accepted for verification
- API calls are simulated with 2-second delays

## Future Enhancements

To make this production-ready, you would need to:
1. Integrate with a real SMS service (Twilio, AWS SNS, etc.)
2. Implement proper backend API endpoints
3. Add proper error handling and logging
4. Implement secure OTP storage and validation
5. Add biometric authentication options
6. Implement proper session management

## Project Structure

```
lib/
├── models/
│   ├── user_model.dart
│   └── auth_state.dart
├── view_models/
│   └── auth_view_model.dart
├── views/
│   ├── login_screen.dart
│   ├── otp_screen.dart
│   └── success_screen.dart
├── services/
│   └── auth_service.dart
└── main.dart
```