
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

 List<Map<String,Object>> get groupedTransactionValues{
   return List.generate(7, (index){
     final weekday=DateTime.now().subtract(Duration(
       days:index,
     ));
     var totalamount=0.0;
     for (var i=0; i<recentTransactions.length;i++){
       if (
           recentTransactions[i].date.day==weekday.day&&
           recentTransactions[i].date.month==weekday.month&&
           recentTransactions[i].date.year==weekday.year
       ){
         totalamount+=recentTransactions[i].amount;
       }
     }
   // print(DateFormat.E().format(weekday));
     // print(totalamount);
     return {'day':DateFormat.E().format(weekday).substring(0,1),'amount':totalamount };
   }).reversed.toList();
 }
 double get totalspending{
   return groupedTransactionValues.fold(0.0, (previousValue, element){
     return previousValue+(element['amount']as double);
   });
 }
  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(

      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: groupedTransactionValues.map((data){
        return Flexible(
             fit:FlexFit.tight,
             child: ChartBar(
             data['day'] as String,
             data['amount'] as double,
            totalspending==0.0?0.0:(data['amount']as double)/totalspending,
            ));

        //Text('${data['day']}:${data['amount']}');
      }).toList(),
      ),
      ) );
  }
}
