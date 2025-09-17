String formattedPhoneNumber ({required String phoneNumber}){
  if ((phoneNumber).isEmpty) return '';
  // Format: +61 X XXXX XXXX
  if ((phoneNumber).length >= 10) {
    return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 4)} ${phoneNumber.substring(4, 8)} ${phoneNumber.substring(8)}';
  }
  return phoneNumber;
}