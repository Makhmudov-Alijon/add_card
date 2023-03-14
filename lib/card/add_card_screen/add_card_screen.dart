import 'package:add_card/card/add_card_screen/add_card_bloc/add_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget.dart';

class AddCardPage extends StatefulWidget {
  static Widget screen() =>
      BlocProvider(create: (context) => AddCardBloc(), child: AddCardPage());

  AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  Map<String, String> images = {
    "1":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk5R3CxXu7Ct0NXkZ6CSyXJs5TokoRV3lK3eOCWpGn0Q&s",
    "2":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNSc4fmFkbXy00fnBtWZ6xEb9CubSLXJ4_XNcTBCBZGQ&s",
    "3":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT88_4nh6oKojByPQq9gunEvQmyn6Y00lCmMJ7is_eldDlt41ba1gEiOw94H6kJBLd1OAU&usqp=CAU",
    "4":
        "https://images.unsplash.com/photo-1540597056574-8d6a9f311f61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGVhc3klMjBnb2luZ3xlbnwwfHwwfHw%3D&w=1000&q=80",
    "5":
        "https://images.unsplash.com/photo-1618042164219-62c820f10723?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZG93bmxvYWR8ZW58MHx8MHx8&w=1000&q=80",
    "6":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTSDBpXHUeg4k-pZg7q0TM3ttMwlrYn1JvFZAY39AP2nyHGUQhX3BG8WI782ZiwB4ylyg&usqp=CAU",
    "7":
        "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXRodW1ibmFpbHx8WjNTd1JVREZtOWd8fGVufDB8fHx8&auto=format&fit=crop&w=420&q=60"
  };
  late CardModel cardModel;
  late AddCardBloc bloc;
  TextEditingController cardNumber=TextEditingController();
  TextEditingController cardDate=TextEditingController();
  TextEditingController cardName=TextEditingController();

  @override
  void initState() {
    cardModel =
        CardModel(cardNumber: '', expiresDate: '', image: images.keys.first,name: '');
    bloc = BlocProvider.of<AddCardBloc>(context);

    bloc.add(AddCardFirstEvent(cardModel: cardModel));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<AddCardBloc, AddCardState>(
        listener: (context,state){
          if(state is BackPageState){
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AddCardMainState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card Number'),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: cardNumber,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLength: 22,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '0000 0000 0000 0000'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Amal qilish muddati'),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: cardDate,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatterDate(),
                        ],
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '12/12'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Enter Name'),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: cardName,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Name'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 350,
                            height: 70,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: images.values.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Opacity(
                                          opacity: state.cardModel.image ==
                                                  images.values.elementAt(index)
                                              ? 0.5
                                              : 1,
                                          child: state.cardModel.image ==
                                                  images.values.elementAt(index)
                                              ? Stack(
                                                  children: [
                                                    Image.network(
                                                        images.values
                                                            .elementAt(index),
                                                        fit: BoxFit.cover,
                                                        width: 100),
                                                    const Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 32),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                                  ],
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    bloc.add(ImageAddEvent(
                                                        cardModel: CardModel(
                                                            cardNumber: '',
                                                            expiresDate: '',
                                                            name: '',
                                                            image: images.values.elementAt(index))));
                                                  },
                                                  child: Image.network(
                                                      images.values
                                                          .elementAt(index),
                                                      fit: BoxFit.cover,
                                                      width: 100)),
                                        )),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      bloc.add(AddDataSqlEvent(cardModel: CardModel(cardNumber: cardNumber.text, expiresDate: cardDate.text, image: state.cardModel.image,name: cardName.text)));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CardModel {
  String cardNumber;
  String expiresDate;
  String image;
  String name;
  CardModel(
      {required this.cardNumber,
      required this.expiresDate,
      required this.image,required this.name});
  Map<String, dynamic> toJson() => {
    "cardNumber" : cardNumber,
    "expiresDate": expiresDate,
    "image": image,
    "name":name
  };
}
