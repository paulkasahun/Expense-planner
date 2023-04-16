import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class TransactionList extends StatelessWidget {
  /*inorder to use transactions here
  * we pass list of transactions to the class*/
  final List<Transaction> _transactions;
  Function deleteTx;

  TransactionList(this._transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    
    return Container(
       height: 450,
        //list view avoids column widget
        child:_transactions.isEmpty? Column(
          children: [
            Text('No transactions added yet!',
            style: Theme.of(context).textTheme.headline6,),
            SizedBox(
              height:15,
            ),

            Container(
              height: 250,
                child:Image.asset('assets/images/waiting.png',fit:BoxFit.cover,)
            ),
            

          ],
        ) :
        ListView.builder(
          itemBuilder: (ctxt,index){
     return Card(
       elevation: 5,
         margin: EdgeInsets.symmetric(
           vertical: 8,
           horizontal: 5,
         ),
         child:ListTile(
       leading: CircleAvatar(
         radius: 30,
         child: Padding(
           padding: EdgeInsets.all(6),
           child: FittedBox(
             child:Text('\$${_transactions[index].amount}'),
           ),
         ),
     ),
       title: Text(_transactions[index].title),
       subtitle: Text(DateFormat.yMMMEd().format(_transactions[index].date),
       style: Theme.of(context).textTheme.bodyText2,),
           trailing: IconButton(icon: Icon(Icons.delete),
           color: Theme.of(context).errorColor,
           onPressed: ()=>deleteTx(_transactions[index].id),),
     ));
       /*Card(
         child: Row(
         children: [
         /*
        * the first child in the row is finished
        * as container class*/
         Container(
         child: Text(
         '\$${_transactions[index].amount.toStringAsFixed(2)}',
         style: TextStyle(
         fontWeight: FontWeight.bold,
         fontSize: 20,
         color: Theme.of(context).primaryColor,
     ),),
            margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15
            ),
            decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor)
            ),
            padding: EdgeInsets.all(10),
            ),
            /*
        * between these two add text field wrapped wi
        * -th card
        * */

            /*
        * title and date column*/
            Column(
            children: [
            Text(
            _transactions[index].title,
            style: Theme.of(context).textTheme.headline6
            ),
            Text(DateFormat.yMMMMd().format(
                _transactions[index].date)),
            ],
            ),
            ],))*/
          },
         itemCount: _transactions.length,
        /* children: _transactions.map((tx){}).toList()
        * this was used before using Listview builder*/

        ));
  }
}
