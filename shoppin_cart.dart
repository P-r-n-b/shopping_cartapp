import 'package:flutter/material.dart';
import 'package:firsttime/constants.dart';
import 'package:firsttime/check_box.dart';

// User-defined data type for each item
class Item {
  final String name;
  final double price;

  Item(this.name, this.price);
}

// Enum class for different pages of the app
enum AppPage{
  Start,
  Vegetables,
  Fruits,
  Bill,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SHOPPING CART'
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,


        backgroundColor: Colors.blue[300],
          actions: [
          IconButton(
          onPressed: () {

    },
      icon: const Icon(Icons.share),
      ),
    ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 40, color: Colors.black,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesPage()));
              },
              child: const Text('Let\'s Shop', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class VegetablesPage extends StatefulWidget {
  const VegetablesPage({Key? key}) : super(key: key);

  @override
  State<VegetablesPage> createState() => _VegetablePageState();
}
class _VegetablePageState extends State<VegetablesPage> {
  List<String> currentState = Constants. vegetablesMap.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetables'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentState.length,
              itemBuilder: (context, index) {
                return CustomCheckBox(objectName: currentState[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FruitsPage()));
            },
            child: const Text('Next', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
class FruitsPage extends StatefulWidget {
  const FruitsPage({Key? key}) : super(key: key);

  @override
  State<FruitsPage> createState() => _FruitPageState();
}
class _FruitPageState extends State<FruitsPage> {
  List<String> currentState = Constants. fruitsMap.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentState.length,
              itemBuilder: (context, index) {
                return CustomCheckBox(objectName: currentState[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BillPage()));
            },
            child: const Text('Next', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
class BillPage extends StatefulWidget {
  const BillPage({Key? key}) : super(key: key);

  @override
  State<BillPage> createState() => _BillPageState();
}
class _BillPageState extends State<BillPage> {
  final array = DataStore.getArray();
  int finalPrice = 0;

  @override
  void initState() {
    //super.initState();
    for (int i = 0; i < array.length; i++) {
      finalPrice += DataStore.getPrice(array[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill'),
        backgroundColor: Colors.blue[300],
        centerTitle: true,

      ),
      body: Column(
        children: [
          const Text('Items Summary', style: TextStyle(color: Colors.black),),
          Expanded(
            child: ListView.builder(
              itemCount: array.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(array[index],
                      style: const TextStyle(color: Colors.black),),
                    Text(DataStore.getPrice(array[index]).toString(),
                      style: const TextStyle(color: Colors.black),)
                  ],
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('TOTAL', style: TextStyle(color: Colors.black),),
              Text(finalPrice.toString(),
                style: const TextStyle(color: Colors.black),)
            ],
          )
        ],
      ),
    );
  }
}
