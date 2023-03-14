import 'dart:async';

import 'package:add_card/card/add_card_screen/add_card_screen.dart';
import 'package:add_card/data_base/data_base.dart';
import 'package:add_card/data_base/locator.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  late CardModel cardModel;
  DatabaseHelper databaseHelper = DatabaseHelper();

  AddCardBloc() : super(AddCardInitial()) {
    on<AddCardEvent>((event, emit) async{
      if(event is ImageAddEvent){
        await cardState(event,emit);
      }
      if(event is AddCardFirstEvent){
        await cardFirstState(event, emit);
      }
      if(event is AddDataSqlEvent){
        await addDataSql(event, emit);
      }
    });
  }
  Future<void> cardFirstState(AddCardFirstEvent event,Emitter<AddCardState> emit) async{
    emit(AddCardMainState(cardModel: event.cardModel));
  }
  Future<void> cardState(ImageAddEvent event,Emitter<AddCardState> emit) async{
    cardModel=event.cardModel;
    emit(AddCardMainState(cardModel: cardModel));
  }
  Future<void> addDataSql(AddDataSqlEvent event ,Emitter<AddCardState> emit) async{
    databaseHelper.insert(event.cardModel);
    emit(BackPageState());
  }

}
