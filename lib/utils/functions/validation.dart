class Validations{
  static bool isValidPhoneNumber(String string) {
    if (string == null || string.isEmpty || string.length != 10) {
      return false;
    }
    const pattern = r'(^[5-9]{1}[0-9]{9}$)';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }


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