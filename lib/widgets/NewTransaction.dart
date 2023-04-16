import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewTransactionState();
  }
}
class NewTransactionState extends State<NewTransaction>{

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  // late final Function addTransaction;//it may have effect
  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if(title.isEmpty||amount<0||selectedDate==null){
      return;
    }
    //this fixes the problem of addtx
    /*
    * this widget is the main widget
    * and if you want to access property of
    * this widget use widget...*/
      widget.addTransaction(
          titleController.text,
          double.parse(amountController.text),
          selectedDate
      );
      Navigator.of(context).pop();
      //this removes bottom sheet after finishing
  }
  void presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickeDate){
      if(pickeDate==null){
        return;
      }
      setState(() {
        selectedDate=pickeDate;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      child:Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_)=>submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_)=>submitData()//need anonymous,
            ),
            Container(
              height:70,
              // padding: EdgeInsets.all(2),
              child:Row(
                children: [
                  Text(selectedDate==null?"No date added yet!":
                     'picked Date: ${DateFormat.yMd().format((selectedDate) as DateTime )}' ,
                  ),
                  TextButton(
                      onPressed: presentDatePicker,
                      child: Text('Choose a date',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
              ElevatedButton(

              onPressed:submitData,//just pass reference,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),

              ),
            ),


          ],
        ),),
    );
  }
}
