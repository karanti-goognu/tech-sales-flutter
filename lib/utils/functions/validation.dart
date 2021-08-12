class Validations{
  static bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }
    const pattern = r'(^[5-9]{1}[0-9]{9}$)';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  // static String validateMobile(String value) {
  //   String pattern = r'(^[5-9]{1}[0-9]{9}$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.length == 0) {
  //     return 'Please enter mobile number';
  //   }else if (value.length!=10) {
  //     return 'Mobile number must be of 10 digit';
  //   } else if (!regExp.hasMatch(value)) {
  //     return 'Please enter valid mobile number';
  //   }
  //   return "Valid mobile number";
  // }

  static bool isEmail(String em) {
    if (em.isEmpty) return false;
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static bool isValidPincode(String pincode) {
    if (pincode.isEmpty) return false;
    String p = r'^[1-9][0-9]{5}$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(pincode);
  }
}