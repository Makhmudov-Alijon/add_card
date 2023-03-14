part of 'card_bloc.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}
class CardGetState extends CardState{
  final List<CardModel> cardModel;
  CardGetState({required this.cardModel});
}