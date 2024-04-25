import 'dart:async';

mixin Validators{
  final validaEmail=
    StreamTransformer<String, String>
      .fromHandlers(
        handleData: (email, sink){
          if(email.contains('@')){
            sink.add(email);
            
          }
          else{
            sink.addError('Email Invalido');
          }
        }
      );
  final validaPassword=
    StreamTransformer<String, String>
      .fromHandlers(  
        handleData: (password, sink){
          if(password.length>=5){
            sink.add(password);
          }
          else{
            sink.addError('Password Invalido');
          }
        }
      );
      final validateNotEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.isNotEmpty) {
        sink.add(value);
      } else {
        sink.addError('Este campo no puede estar vacío');
      }
    },
  );

}