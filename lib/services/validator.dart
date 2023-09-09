class Validator {
  // Validator._();

  static String? validateName(String? name) {
    if ((name?.length ?? 0) < 5 ) {
      return "Provided name is very short" ;
    }
    if (name == null) {
      return null;
    }
    bool nameValid = RegExp(r"^[a-zA-Z]+").hasMatch(name);
    return nameValid ? null : "Name is not valid p";
  }
  static String? validatePhone(String? phone) {
    return (phone?.length ?? 0) != 11 ? "Provided phone number like 01XXXXXXXXX" : null;
  }
  static String? validateCity(String? city) {
    return (city?.length ?? 0) < 1 ? "Provided City" : null;
  }

  static String? validatePassword(String? password) {
    return (password?.length ?? 0) < 6 ? "Password is too short" : null;
  }
  static String? validateConfirmationPassword(String? password,String? confirmationPassword) {
    return password== confirmationPassword ? "Password is too short" : null;
  }
  static String? validateEmail(String? email) {
    if (email == null) {
      return null;
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid ? null : "Email is not valid";
  }



// static String? validateName(String? name) {
//   return (name?.length ?? 0) < 5 ? "Provided name is very short" : null;
// }

}
