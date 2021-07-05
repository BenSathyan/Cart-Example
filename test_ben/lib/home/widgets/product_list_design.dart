import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ben/home/model/product_responce_model.dart';


// ignore: must_be_immutable
class Product extends StatefulWidget {
  List<GetProductResponseListModel> productList;
  int index;

  Product(this.productList, this.index);

  _Product createState() => _Product();
}

class _Product extends State<Product> {

  @override
  void initState() {
    print("------------ Add On -----------");
    print(widget.productList[widget.index].dish[0].addonCat);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.productList[widget.index].dish.length != 0 ?Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.productList[widget.index].dish.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  /* Navigator.push(context,
                MaterialPageRoute(builder: (context) => StudentProfile()));*/
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 248, 248, .9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            leading:  Column(
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                        widget.productList[widget.index].dish[index].dishName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                widget.productList[widget.index].dish[index].dishCurrency +" " +widget.productList[widget.index].dish[index].dishPrice.toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            Spacer(),
                                            Text(
                                                widget.productList[widget.index].dish[index].dishCalories.toString()+" calories",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            title: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0),
                                    child: Container(
                                      height: 65,
                                        child: Image.network("https://picsum.photos/250?image=9"))),//Image.network(widget.productList[widget.index].dish[index].dishImage))),
                                Spacer(),
                              ],
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 100.0, bottom: 8.0,top: 0),
                          child: Align(
                            alignment: Alignment.centerLeft, child: Text(
                              widget.productList[widget.index].dish[index].dishDescription,
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: Colors.black45)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.remove,color: Colors.white,),
                                    Spacer(),
                                    Text("0",style: TextStyle(color:Colors.white,)),
                                    Spacer(),
                                    Icon(Icons.add,color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        widget.productList[widget.index].dish[0].addonCat.length !=0? Align(
                            alignment: Alignment.centerLeft,
                            child: Text("hai")):Container()
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
            : Center(child: Text("No Circular Found")),
    );
  }
}
