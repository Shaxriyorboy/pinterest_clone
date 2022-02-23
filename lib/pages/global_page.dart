import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest_app/animation/fade_animation.dart';
import 'package:pinterest_app/pages/home_page.dart';
import 'package:pinterest_app/pages/message_page.dart';
import 'package:pinterest_app/pages/profil_page.dart';
import 'package:pinterest_app/pages/search_page.dart';
class GlobalPage extends StatefulWidget {
  const GlobalPage({Key? key}) : super(key: key);
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  int _selected = 0;
  final _pageController = PageController();
  bool hasInternet = false;
  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        setState(() {
          hasInternet = true;
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          hasInternet = true;
        });
      }else{
        setState(() {
          hasInternet = false;
        });
      }
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet?WillPopScope(
      onWillPop: () async{
        if(_selected!=0){
          setState(() {
            _selected = 0;
            _pageController.jumpToPage(_selected);
          });
          return false;
        }else{
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FadeAnimation(1, PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index){
              setState(() {
                _selected = index;
              });
            },
            children: [
              HomePage(),
              SearchPage(),
              MessagePage(),
              ProfilPage(),
            ],
          )),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FadeAnimation(3,floatWidget()),
        ),
      ),
    ):Scaffold(
      body: Center(
        child: Text("You was not connection internet"),
      ),
    );
  }

  Container floatWidget() {
    return Container(
      width: 200,
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              splashRadius: 1,
              icon: Icon(
                FontAwesomeIcons.home,
                color: _selected != 0 ? Colors.grey : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _selected = 0;
                });
                _pageController.jumpToPage(_selected);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              splashRadius: 1,
              icon: Icon(
                FontAwesomeIcons.search,
                color: _selected != 1 ? Colors.grey : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _selected = 1;
                });
                _pageController.jumpToPage(_selected);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              splashRadius: 1,
              icon: FaIcon(
                FontAwesomeIcons.commentDots,
                color: _selected == 2 ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _selected = 2;
                });
                _pageController.jumpToPage(_selected);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              splashRadius: 1,
              icon: Container(
                padding: EdgeInsets.all(2),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: _selected == 3
                      ? Border.all(width: 2.5, color: Colors.black)
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl:
                    "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                    placeholder: (context, url) => const Image(
                      height: 25,
                      width: 25,
                      image: AssetImage("assets/images/img.png"),
                    ),
                    height: 25,
                    width: 25,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selected = 3;
                });
                _pageController.jumpToPage(_selected);
              },
            ),
          ),
        ],
      ),
    );
  }
}
