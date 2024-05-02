class Config {
  static const String port = "8081";
  static const String meterPort = "8082";
  static const String utilityPort = "9001";
  static const String apiVersion = "api/v1";
  static const String apiUrl = "localhost:$port";
  static const String meterApiUrl = "localhost:$meterPort";
  static const String utilityApiUrl="localhost:$utilityPort";

  static const String login = "/$apiVersion/auth/authenticate";
  static const String register = "/$apiVersion/auth/register";
  static const String fetchUserDetails = "/$apiVersion/user/details";
  static const String fetchUserMessages = "/$apiVersion/user/messages";

  static const String updateUserName = "/$apiVersion/user/update";
  static const String updatePassword = "/$apiVersion/user/update";
  static const String updateAddress = "/$apiVersion/user/update/address";


  static const String fetchRecentReading ="/$apiVersion/meter-reading/utility-account/latest/";
  static const String invalidateImage = "/$apiVersion/meter-reading/discard/";
  static const String history = "/$apiVersion/meter-reading/utility-account/";

  static const String uploadMeterImage = "/api/meter-images/upload";
  static const String uploadProfileImage = "/api/profile-image/upload";

  static const String uploadBoundingBox = "/api/meter-image/bounding-box";


  //UAN
  static const String fetchUAN = "/$apiVersion/utility-accounts/searchByAddress";

  /// autocomplete
  static const String addressAPI = "api.geoapify.com";
  static const String tail = "/v1/geocode/autocomplete";
  static const String apiKey = "84e60098000d43a1b438ddccf935b274";
}
