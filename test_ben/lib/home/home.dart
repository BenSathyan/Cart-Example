import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ben/api_client/object_factory.dart';
import 'package:test_ben/auth/login.dart';
import 'package:test_ben/home/widgets/drawer.dart';
import '../utils.dart';
import 'cart.dart';
import 'model/product_responce_model.dart';

class ProductListHome extends StatefulWidget {
  @override
  _ProductListHomeState createState() => _ProductListHomeState();
}

class _ProductListHomeState extends State<ProductListHome>
    with SingleTickerProviderStateMixin {
  Utils utils = Utils();
  List<GetProductResponseListModel> productList = new List();
  List<String> tabsText = new List();
  TabController _tabController;
  String name, profilePic, userId , phone;
  List<CategoryDishes> cart = new List();
  int cartCount = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: productList.length,
        child: Scaffold(
          drawer: NavigationDrawer(name.toString() == 'null'?"":name, profilePic.toString() == 'null'?"":profilePic, userId,phone.toString() =="null"?"":phone),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorWeight: 3.0,
                indicatorColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                tabs: tabMaker()),
            title: Text('Tabs Demo'),
            actions: [
              Badge(
                borderRadius: BorderRadius.circular(5),
                position: BadgePosition.topEnd(top: 5, end: 5),
                badgeContent: Text(
                  cartCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    if (cartCount != 0) {
                      Navigator.of(context)
                          .push(
                        new MaterialPageRoute(
                            builder: (_) =>
                            new CartProductList(productList, 0, cartCount)),
                      ).then((val) => resetCartNumber(val));
                    }else{
                      utils.showToast("Please add at least one product");
                    }
                  }
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: productList.isEmpty
                ? <Widget>[]
                : productList[0].dish.map((dynamicContent) {
                    return productList[_selectedIndex].dish.length != 0
                        ? Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  productList[_selectedIndex].dish.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    child: Row(
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
                                              color: productList[_selectedIndex]
                                                      .dish[index]
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
                                                  color: productList[
                                                              _selectedIndex]
                                                          .dish[index]
                                                          .dishAvailability
                                                      ? Colors.green
                                                      : Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0,
                                                            vertical: 5.0),
                                                    leading: Column(
                                                      children: [
                                                        Container(
                                                          width: 220,
                                                          child: Text(
                                                              productList[
                                                                      _selectedIndex]
                                                                  .dish[index]
                                                                  .dishName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width: 220,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      productList[_selectedIndex]
                                                                              .dish[
                                                                                  index]
                                                                              .dishCurrency +
                                                                          " " +
                                                                          productList[_selectedIndex]
                                                                              .dish[
                                                                                  index]
                                                                              .singleDishPrice
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  Spacer(),
                                                                  Text(
                                                                      productList[_selectedIndex]
                                                                              .dish[
                                                                                  index]
                                                                              .dishCalories
                                                                              .toString() +
                                                                          " calories",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Container(
                                                                height: 75,
                                                                child: Image
                                                                    .network(
                                                                        "https://picsum.photos/250?image=9"))),
                                                        //Image.network(widget.productList[widget.index].dish[index].dishImage))),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 100.0,
                                                          bottom: 8.0,
                                                          top: 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        productList[
                                                                _selectedIndex]
                                                            .dish[index]
                                                            .dishDescription,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black45)),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (productList[_selectedIndex]
                                                                            .dish[index]
                                                                            .count ==
                                                                        0) {
                                                                      productList[_selectedIndex]
                                                                          .dish[
                                                                              index]
                                                                          .count = 0;
                                                                    } else {
                                                                      productList[_selectedIndex]
                                                                          .dish[
                                                                              index]
                                                                          .count = productList[_selectedIndex]
                                                                              .dish[index]
                                                                              .count -
                                                                          1;
                                                                    }
                                                                    getCartCount(
                                                                        index);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Spacer(),
                                                            Text(
                                                                productList[
                                                                        _selectedIndex]
                                                                    .dish[index]
                                                                    .count
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Spacer(),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    productList[
                                                                            _selectedIndex]
                                                                        .dish[
                                                                            index]
                                                                        .count = productList[_selectedIndex]
                                                                            .dish[index]
                                                                            .count +
                                                                        1;
                                                                  });
                                                                  getCartCount(
                                                                      index);
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                productList[_selectedIndex]
                                                            .dish[index]
                                                            .addonCat
                                                            .length !=
                                                        0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "  Customizations Available",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 17),
                                                            )),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(child: Text("No Circular Found"));
                  }).toList(),
          ),
        ),
      ),
    );
  }

  getProductList() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isMobile = prefs.getBool("isMobile");
    final User user = auth.currentUser;
      print(isMobile);
      try {
        if (isMobile) {
          name = "";
          userId = user.uid;
          phone = user.phoneNumber;
          profilePic =
          "https://www.pngitem.com/pimgs/m/146-1468465_early-signs-of-conception-user-profile-icon-hd.png";
        } else {
          name = user.displayName;
          userId = user.uid;
          profilePic = user.photoURL;
          phone = "";
        }
      }catch(e){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Login()),
                (route) => false);
      }
      print(phone);
    Response response = await ObjectFactory().apiClient.getProductList();
    print("--------- Product List ----------");
    response.data[0]['table_menu_list'].forEach((element) {
      GetProductResponseListModel responseFromJson =
          GetProductResponseListModel.fromJson(element);
      print(responseFromJson.menuCategory);
      productList.add(responseFromJson);
    });
    _tabController = new TabController(length: productList.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
    setState(() {});
  }

  tabMaker() {
    print("-------------  Tab Bar  ----------------");
    List<Tab> tabs = List();
    for (var i = 0; i < productList.length; i++) {
      tabs.add(Tab(
          child: Text(productList[i].menuCategory,
              style: new TextStyle(fontSize: 15, color: Colors.red))));
    }
    setState(() {});
    return tabs;
  }

  getCartCount(int index) {
    cartCount = 0;
    productList.forEach((element) {
      element.dish.forEach((productElement) {
        if (productElement.count != 0) {
          setState(() {
            cartCount = cartCount + 1;
          });
        }
      });
    });
  }
  resetCartNumber(int val){
    print("++++++++++++++  Count Called  ++++++++++++++");
    setState(() {
      cartCount = val;
    });
  }
}
