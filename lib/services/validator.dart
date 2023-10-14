class Validator {

  static String? validateName(String? name) {
    if ((name?.length ?? 0) < 3 || name == null) {
      return "Name is very short";
    }

    bool nameValid = RegExp(r"^[a-zA-Z]+").hasMatch(name);
    return nameValid ? null : "Name is not valid";
  }

  static String? validatePhone(String? phone) {
    if ((phone?.length ?? 0) != 11 || phone == null) {
      return "Name is very short";
    }

    bool nameValid = RegExp(r"^01[0,1,2,5]{1}[0-9]{8}$").hasMatch(phone);
    return nameValid
        ? "phone number not valid"
        : null;
  }

  static String? validateCity(String? city) {
    return (city?.length ?? 0) < 1 ? "Provided City" : null;
  }

  static String? validatePassword(String? password) {
    return (password?.length ?? 0) < 8 ? "Password is too short" : null;
  }

  static String? validateEmpty(String? string) {
    return (string?.length ?? 0) == 0 ? "" : null;
  }

  static String? validateEmail(String? email) {
    if (email == null) {
      return null;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid ? null : "Email is not valid";
  }

// static String? validateName(String? name) {
//   return (name?.length ?? 0) < 5 ? "Provided name is very short" : null;
// }
}
