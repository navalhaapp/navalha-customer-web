import 'dart:convert';
import 'dart:html'; // Adicione esta linha

class CustomerDB {
  final String name;
  final String image;
  final String customerId;
  final String token;
  final String email;
  final String birthDate;
  final String userID;
  final String password;

  CustomerDB({
    required this.name,
    required this.image,
    required this.customerId,
    required this.token,
    required this.email,
    required this.birthDate,
    required this.userID,
    required this.password,
  });

  // Método para converter os dados em um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'customerId': customerId,
      'token': token,
      'email': email,
      'birthDate': birthDate,
      'userID': userID,
      'password': password,
    };
  }

  // Método para criar um objeto CustomerDB a partir de um mapa
  factory CustomerDB.fromMap(Map<String, dynamic> map) {
    return CustomerDB(
      name: map['name'],
      image: map['image'],
      customerId: map['customerId'],
      token: map['token'],
      email: map['email'],
      birthDate: map['birthDate'],
      userID: map['userID'],
      password: map['password'],
    );
  }
}

class LocalStorageManager {
  static const String KEY_CUSTOMER = 'customer_db';

  // Método para salvar o objeto CustomerDB no LocalStorage
  static void saveCustomer(CustomerDB customer) {
    final Map<String, dynamic> customerMap = customer.toMap();
    final String jsonCustomer = json.encode(customerMap);
    window.localStorage[KEY_CUSTOMER] = jsonCustomer;
  }

  // Método para recuperar o objeto CustomerDB do LocalStorage
  static CustomerDB? getCustomer() {
    final String? jsonCustomer = window.localStorage[KEY_CUSTOMER];
    if (jsonCustomer != null) {
      final Map<String, dynamic> customerMap = json.decode(jsonCustomer);
      return CustomerDB.fromMap(customerMap);
    }
    return null;
  }

  static void clearCustomer() {
    window.localStorage.remove(KEY_CUSTOMER);
  }
}
