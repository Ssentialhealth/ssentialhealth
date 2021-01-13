import 'dart:async';

import 'package:flutter/cupertino.dart';

class ValidationMixin{
  final validatorEmail = new StreamTransformer<String, String>.fromHandlers(
    handleData:(email, sink) {
      if(!email.contains('@')) {
        sink.addError(
          'Please enter a valid Email'
        );
      }else if(email.indexOf('o') == -1){
        sink.addError('Smh Fix it');
      }else {
        sink.add(email);
      }
  },
  );

  final validatorPassword = new StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length > 8) {
        sink.add(password);
      } else {
        sink.addError('Use  more than 8 characters');
      }
    }
  );
}