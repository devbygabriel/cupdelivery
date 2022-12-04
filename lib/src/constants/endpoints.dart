const String baseUrl = 'http://164.92.120.210:7766';
const String authUsername = 'Basic ZXJwOjcxNjgxMDk1';
String token = '';
String refreshToken = '';

abstract class Endpoints {
  static const String getToken = '$baseUrl/auth/login';
  static const String refreshToken = '$baseUrl/refresh_token';
  static const String signin = '$baseUrl/customer/login';
  static const String singup = '$baseUrl/customer';
  static const String changePassword = '$baseUrl/customer/password';
  static const String updateUser = '$baseUrl/customer';
  static const String getAllProducts = '$baseUrl/products';
  static String getAllProductsByTitle = '$baseUrl/products/';
  static String getCartItems = '$baseUrl/cart/';
  static String addItemToCart = '$baseUrl/cart';
  static String changeItemQuantity = '$baseUrl/cart';
  static String checkout = '$baseUrl/sales';
  static String getAllOrders = '$baseUrl/sales/';
  static String getOrderItems = '$baseUrl/sales/products/';
}
