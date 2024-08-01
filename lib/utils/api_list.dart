class ApiList {
  static String? baseUrl = "https://sabify.sabsoft.com.pk";
  static int? websiteId = 25;
  static int? companyId = 92;
  static String getAllData = "${baseUrl!}/api/website/get-detail/$websiteId";
  static String login = "${baseUrl!}/api/website/customer-login";
  static String verifyOtp = "${baseUrl!}/api/website/verify-otp";
  static String getCustomerAddresses =
      "${baseUrl!}/api/website/get-customer-record";
  static String saveCustomerAddress =
      "${baseUrl!}/api/website/save-customer-address";
  static String removeCustomerAddress =
      "${baseUrl!}/api/website/save-customer-address";
}
