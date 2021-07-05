import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ben/home/model/product_responce_model.dart';
import 'package:test_ben/utils.dart';

// ignore: must_be_immutable
class CartProductList extends StatefulWidget {
  List<GetProductResponseListModel> productList;
  int index;
  int count;

  CartProductList(this.productList, this.index, this.count);

  _CartProductList createState() => _CartProductList();
}

class _CartProductList extends State<CartProductList> {
  List<CategoryDishes> cartProductList = new List();
  double total = 0;
  int count = 0 ;
  Utils utils = new Utils();
  @override
  void initState() {
    print("------------ Add On -----------");
    print(widget.productList[widget.index].dish[0].addonCat);
    getCartValue();
    getCartCount(0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
         Navigator.pop(context, count);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context, count);
            },
          ),
          title: Text(
            "Order Summary",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: cartProductList.length != 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(26, 63, 20, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              child: Center(
                                  child: Text(
                                    count.toString() +
                                    " Dishes - " +
                                    count.toString() +
                                    " Items",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              )),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: cartProductList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 22.0, left: 10),
                                            child: Container(
                                              height: 15,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: cartProductList[index]
                                                        .dishAvailability
                                                    ? Colors.green
                                                    : Colors.red,
                                              )),
                                              //child:Icon(Icons.adjust_sharp ,color: Colors.green,size: 10,),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    color: cartProductList[index]
                                                            .dishAvailability
                                                        ? Colors.green
                                                        : Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.only(
                                                top: 22.0, left: 10),
                                            child: Text(
                                                cartProductList[index].dishName,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Container(
                                                              height: 59,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    width: 120,
                                                                    decoration: BoxDecoration(
                                                                        color: Color
                                                                            .fromRGBO(
                                                                                26,
                                                                                63,
                                                                                20,
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                setState(() {
                                                                                  if (cartProductList[index].count <= 0) {
                                                                                    cartProductList[index].count = 0;
                                                                                    print("++++++++++ sucess ++++++++++");
                                                                                    cartProductList.removeAt(index);
                                                                                  } else {
                                                                                    cartProductList[index].count = cartProductList[index].count - 1;
                                                                                    total = total - cartProductList[index].singleDishPrice;
                                                                                  }
                                                                                  if (total < 0) {
                                                                                    total = 0;
                                                                                  }
                                                                                });
                                                                                cartProductList[index].dishPrice = cartProductList[index].singleDishPrice * cartProductList[index].count;
                                                                                getCartCount(index);
                                                                              },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.remove,
                                                                                color: Colors.white,
                                                                              )),
                                                                          Spacer(),
                                                                          Text(
                                                                              cartProductList[index]
                                                                                  .count
                                                                                  .toString(),
                                                                              style:
                                                                                  TextStyle(
                                                                                color: Colors.white,
                                                                              )),
                                                                          Spacer(),
                                                                          GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                setState(() {
                                                                                  cartProductList[index].count = cartProductList[index].count + 1;
                                                                                });
                                                                                cartProductList[index].dishPrice = cartProductList[index].singleDishPrice * cartProductList[index].count;
                                                                                total = total + cartProductList[index].singleDishPrice;
                                                                                getCartCount(index);
                                                                                  },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.add,
                                                                                color: Colors.white,
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              //Image.network(widget.productList[widget.index].dish[index].dishImage))),
                                                            )),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "   INR " +
                                                                  cartProductList[
                                                                          index]
                                                                      .dishPrice
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, left: 38),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "INR " +
                                                  cartProductList[index]
                                                      .singleDishPrice
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 38, bottom: 20),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '\n' +
                                                  cartProductList[index]
                                                      .dishCalories
                                                      .toString() +
                                                  " calories",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "INR " + total.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: (){
                          utils.showAlert(context,"Order successfully placed");
                        },
                        child: Container(
                            height: 45,
                            margin:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(26, 63, 20, 1),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Place Order",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ))),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: Text("No Product Found")),
      ),
    );
  }

  getCartValue() {
    print("************* Function Called ***************");
    cartProductList.clear();
    widget.productList.forEach((element) {
      element.dish.forEach((dishElement) {
        if (dishElement.count != 0) {
          cartProductList.add(dishElement);
        }
      });
    });
    cartProductList.forEach((element) {
      element.dishPrice = element.dishPrice * element.count;
      total = element.dishPrice + total;
    });
  }

    getCartCount(int index) {
    if(cartProductList[index].count == 0){
      cartProductList.removeAt(index);
    }
     count = 0;
    cartProductList.forEach((element) {
      if(element.count != 0){
        count = count+1;
      }
    });
    print("+++++++++++++ Count +++++++++++++");
    print(count);
   }
}
