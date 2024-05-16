
class Config {
  static const String port = "5000";
  static const String meterPort = "5000";
  static const String utilityPort = "5000";
  static const String apiVersion = "api/v1";
  static const String apiUrl = "utilitycoreservices.us-east-1.elasticbeanstalk.com:$port";
  static const String meterApiUrl = "utilitycoreservices.us-east-1.elasticbeanstalk.com:$meterPort";
  static const String utilityApiUrl="utilityuserservice.us-east-1.elasticbeanstalk.com:$utilityPort";
  static const String login = "/$apiVersion/auth/authenticate";
  static const String register = "/$apiVersion/auth/register";
  static const String fetchUserDetails = "/$apiVersion/user/details";
  static const String fetchUserMessages = "/$apiVersion/user/messages";
  static const String updateUserName = "/$apiVersion/user/update";
  static const String updatePassword = "/$apiVersion/user/update";
  static const String updateAddress = "/$apiVersion/user/updateAddress";
  static const String fetchRecentReading ="/$apiVersion/meter-reading/utility-account/latest/";
  static const String invalidateImage = "/$apiVersion/meter-reading/discard/";
  static const String confirmImage="/$apiVersion/meter-reading/confirm/";
  static const String payBill="/$apiVersion/meter-reading/billpay/";
  static const String history = "/$apiVersion/meter-reading/utility-account/";
  static const String uploadMeterImage = "/api/meter-images/upload";
  static const String uploadProfileImage = "/api/profile-image/upload";
  static const String uploadBoundingBox = "/$apiVersion/meter-reading/";
  //UAN
  static const String fetchUAN = "/$apiVersion/utility-accounts/searchByAddress";
  /// autocomplete
  static const String addressAPI = "api.geoapify.com";
  static const String tail = "/v1/geocode/autocomplete";
  static const String apiKey = "84e60098000d43a1b438ddccf935b274";
}
