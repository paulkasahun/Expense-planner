/*import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
void main()=>runApp(ExpensePlanner());
class  ExpensePlanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpensePlannerHomePage(),
      title: 'Expense Planner',
    );
  }
}
class ExpensePlannerHomePage extends StatelessWidget{
  /*
  * here we need list of transactions
  * latter each element of this list is
  *  mapped to card widget
  * itteratively/recursively*/
  List<Transaction> transactions =[
    Transaction(
        id: 'good',
        title: 'New Shoe', amount:'23', date:DateTime.now() ),
    Transaction(
        id: 'bad',
        title: 'Grocery item', amount:'25', date:DateTime.now() )
  ];
Widget build(BuildContext context){
  return Scaffold(

  appBar: AppBar(title: Text('Expense Planner'),),
  body: Column(
    /*
    * MainAxisAlignment:MainAxisAlignment
    *         .center...takes the column list into
    *  the middle of the column
    *          .end....to the end
    *          .start... to the start
    *          .space between...makes space bn */
    mainAxisAlignment: MainAxisAlignment.start,
    /*
    * crossAxisAlignment
    *         .center ... takes the column  list horizontlly  to
    *          the center
    *          .end... to the end
    *          .stretch... stretches to both ends
    *
    *      */
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      /*
        * Here the card widget takes the size of
        * its child
        * so wrapping it in container or wrapping
        * container within the card is the same
        * and takes the size of the container.*/
      Container(
        width: double.infinity,
       child: Card(
         color: Colors.blue,
         elevation: 5,
         child: Text(
           'Expense Chart',
           textAlign: TextAlign.center,
           style: TextStyle(
             color: Colors.white,
             fontSize: 20
           ),
         ),
       ),
      ),
      /*
      * all the transactions Lists are displayed
      * below this.
      * so map every transaction into a card widget
      * using the column widget
      * */
     Column(
       children: transactions.map(
           (tx){
             return Card(
         child:Row(
  children: [
    /*container for the amount/price
    * */
    Container(
        child:Text(
            '\$${tx.amount}',
          style: TextStyle(
     fontSize: 20,
     color: Colors.purple,
     fontWeight: FontWeight.bold
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
        ),
       padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         border: Border.all(
           color: Colors.purple,
           width: 2,
         ),
       ),

    ),
    /*container for the amount/price
    * */
    //column to arrange title and date
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
          tx.title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
          DateFormat.yMMMMd().format(tx.date),
          style: TextStyle(
            color: Colors.grey,
          ),
        )
    ],),
  ],),);
           }
       ).toList(),
       
     ),
    ],
  ),


  );
}}*/

import './widgets/chart.dart';
import './widgets/NewTransaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/TransactionList.dart';

void main()=>runApp(ExpensePlanner());

class ExpensePlanner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple
          ).copyWith(
              secondary: Colors.amber),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              fontFamily: 'Sandquicks',
              fontSize: 29,
              fontWeight: FontWeight.bold
            ),
          ).bodyText2,
          titleTextStyle: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            )
          ).headline6
        ),
        /*
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
            //headline6==title
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ).bodyText2,
            titleTextStyle: ThemeData.light().textTheme.copyWith(
            //headline6==title
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).headline6
        ),*/

      ),
      debugShowCheckedModeBanner: false,
      home: _ExpensePlannerHomepage(),
      title: 'Expense Planner',
    );
  }
}

class _ExpensePlannerHomepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpensePlannerHomepageState();
  }
}
class _ExpensePlannerHomepageState extends State<_ExpensePlannerHomepage>{
  final titleController = TextEditingController();
  final  amountController= TextEditingController();
  List<Transaction> _userTransactions=[
    // Transaction(id: '34', title: 'New shoe', amount: 23.4, date: DateTime.now()),
    // Transaction(id: '25', title: 'Grocery Items', amount: 24, date: DateTime.now())
  ];

  void _addNewTransaction( String title, double amount,DateTime choosenDate){
    final newTx = Transaction(
        id:DateTime.now().toString(),
        title: title,
        amount: amount,
        date: choosenDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  void _startAddNewTransaction( BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_){
        return GestureDetector(
          onTap:(){},
            behavior:HitTestBehavior.opaque ,
          child:NewTransaction(_addNewTransaction));
      },
  );
  }
  List<Transaction> get _recentTransactions{
    return _userTransactions.where(
            (tx){
              return tx.date.isAfter(
                DateTime.now().subtract(Duration(
                  days: 7,
                ))
              );
            }
    ).toList();
  }

  void deleteTransaction(String id){
   setState(() {
     _userTransactions.removeWhere((element) =>element.id==id);
   });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        textTheme: ThemeData.light().textTheme.copyWith(
        titleMedium: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,

        )

        ),
        actions: [
          IconButton(
              onPressed:()=> _startAddNewTransaction(context),
              icon: Icon(Icons.add),
          )
        ],
        title: Text(
        'Expense Planner',

        textAlign: TextAlign.center,),),
      body:SingleChildScrollView(
      child:Column(
        /*
        * this is the main skeleton*/
        children: [
          /*Container(
              width: double.infinity,
        child:Card(
             color: Colors.blue,
            child: Text(
                'Expense Chart',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          )),*/
          /*Chart ends Here
          * now we are going to start to add transaction
          * list*/
          //add Textfield here
         /* UserTransaction()
         * this is previously used*/
          Chart(_recentTransactions),
          TransactionList(_userTransactions,deleteTransaction),
          /*

          * if u want to avoid managing them here
          * create another widget*/
        ],

      ),
      /*body column*/

    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context),
      ),
    );
  }
}
