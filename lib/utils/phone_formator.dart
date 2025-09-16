String formattedPhoneNumber ({required String countryCode, required String phoneNumber}){
  if ((countryCode + phoneNumber).isEmpty) return '';
  // Format: +61 X XXXX XXXX
  if ((countryCode + phoneNumber).length >= 10) {
    return '${countryCode + phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 4)} ${phoneNumber.substring(4, 8)} ${phoneNumber.substring(8)}';
  }
  return countryCode + phoneNumber;
}