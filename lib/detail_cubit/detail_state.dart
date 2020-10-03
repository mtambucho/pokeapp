part of 'detail_cubit.dart';

class DetailState extends Equatable {
  final Pokemon pokemon;
  const DetailState({this.pokemon});
  @override
  List<Object> get props => [pokemon];
}
