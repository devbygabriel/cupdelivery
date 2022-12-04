import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu e-mail!';
  }

  if (!email.isEmail) return 'Digite um e-mail válido!';

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha!';
  }

  if (password.length < 8) {
    return 'A senha deve ter 8 ou mais caracteres';
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome!';
  }

  final names = name.split(' ');

  if (names.length == 1) return 'Digite seu nome completo!';

  return null;
}

String? numberValidator(String? number) {
  if (number == null || number.isEmpty) {
    return 'Digite um número!';
  }

  return null;
}

String? cityValidator(String? city) {
  if (city == null || city.isEmpty) {
    return 'Digite uma cidade!';
  }

  return null;
}

String? districtValidator(String? district) {
  if (district == null || district.isEmpty) {
    return 'Digite um estado!';
  }

  return null;
}

String? publicPlaceValidator(String? publicPlace) {
  if (publicPlace == null || publicPlace.isEmpty) {
    return 'Digite um endereço válido!';
  }

  final names = publicPlace.split(' ');

  if (names.length == 1) return 'Digite seu endereço completo!';

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular!';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido!';
  }

  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um CPF!';
  }

  if (!cpf.isCpf) return 'Digite um CPF válido!';

  return null;
}

String? cepValidator(String? cep) {
  if (cep == null || cep.isEmpty) {
    return 'Digite um CEP!';
  }

  if (cep.length < 9) {
    return 'Digite um CEP válido!';
  }

  return null;
}
