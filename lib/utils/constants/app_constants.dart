class AppConstants {
  static RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegExp =
      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
  static RegExp textRegExp = RegExp("[a-zA-Z]");
  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static const String users = "users";
  static String cards = "cards";
  static String cardsDb = "cards_db";
  static String clientID =
      "678672927365-0gs5tevknu07c7kln0mep0ddguhpssr2.apps.googleusercontent.com";
}
