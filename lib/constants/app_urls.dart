

class AppUrls {

  static const String consumerKey = "df4912967a5a06e2325e97740d7339895713d608e4e0925bc9d68cb1bc6f3143";
  static const String consumerSecret = "0187a226d18f5fe930b2ad91a4da2de7aa569ee2912bf84292c1974e70de791e";
  static final String _accountID = "TSTDRV1967913";//locator<StoreServices>().getAccountID();
  static const String token = "d7679243178115be3b3ff21d256ffdff4f255fc5373fe0013e65f7a5daee0a5d";
  static const String secret = "fb145ab0a20149828a07c06902482dec8b8661b3e43ad90f03902dcc52c5f14a";

  static final String _companyURL = "https://$_accountID.suitetalk.api.netsuite.com";
  static String path = "$_companyURL/services/rest";
  static String roles = "https://rest.netsuite.com/rest/roles";
  static String issueToken = "https://$_accountID.restlets.api.netsuite.com/rest/issuetoken?consumerKey=${AppUrls.consumerKey}&name=<optional name>";
}