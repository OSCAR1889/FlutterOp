import 'dart:async';
import 'package:proyect/src/bloc/validators.dart';

class Bloc with Validators {
  static final Bloc _singleton = Bloc._internal();

  factory Bloc() {
    return _singleton;
  }

  Bloc._internal(){
    _usuarios.add(User(email: 'op1515@gmail.com', password: '12345', name:'Jose Manuel Guerra Torres'));
    _usuarios.add(User(email: 'admin@gmail.com', password: '151515', name:'Oscar Evaristo Perez Becerra'));
    _usuarios.add(User(email: 'jair@gmail.com', password: '15151', name:'Jair Emmanuel Ramirez Flores'));
  }

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  final List<User> _usuarios = [];

  User? _currentUser; // Variable para almacenar el usuario actual

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password => _passwordController.stream.transform(validaPassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get userName {
    if (_currentUser != null) { 
      return _currentUser!.name; 
    } else {
      return ''; 
    }
  }

  void setUser(User user) {
    _currentUser = user; 
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }

  bool validarCredenciales(String email, String password) {
    final user = _usuarios.firstWhere((user) => user.email == email && user.password == password);
    if (user != null) {
      setUser(user); 
      return true;
    } else {
      return false;
    }
  }
}

final bloc = Bloc();

class User {
  final String email;
  final String password;
  final String name;

  User({required this.email, required this.password,required this.name});
}
