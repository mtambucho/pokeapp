import 'package:equatable/equatable.dart';

class CustomException implements Exception, Equatable {
  final _message;

  CustomException(this._message);

  String get message => _message;

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [_message];
}
