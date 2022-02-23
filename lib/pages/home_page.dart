import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_app/models/user_model.dart';
import 'package:pinterest_app/pages/home_photo_page.dart';
import 'package:pinterest_app/services/db_service.dart';
import 'package:pinterest_app/services/http_service.dart';
import 'package:pinterest_app/services/log_service.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadPage = false;
  int postsLength = 0;
  bool netCheck = false;
  List<User> _list = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<User> listHive = [];

  void _userList() async {
    setState(() {
      isLoading = true;
    });
    await Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) {
      Log.d(response!);
      _showResponse(response);
    });
  }

  void _showResponse(String response) {
    List<User> list = Network.parsePostList(response);
    _list.clear();
    postsLength = list.length;
    setState(() {
      isLoading = false;
      _list = list;
      listHive = list;
    });
  }

  void _fetchPosts() async {
    int pageNumber = (_list.length ~/ postsLength + 1);
    String? response =
        await Network.GET(Network.API_LIST, Network.paramsPage(pageNumber));
    List<User> newPosts = Network.parsePostList(response!);
    _list.addAll(newPosts);
    setState(() {
      isLoadPage = false;
    });
  }

  @override
  void initState() {
    SystemChannels.deferredComponent;
    super.initState();
    _userList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadPage = true;
        });
        _fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _list.isNotEmpty
            ? homePage()
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Column homePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: appbarCatigory(),
        ),
        Expanded(
          child: MasonryGridView.count(
              controller: _scrollController,
              itemCount: _list.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return itemOfGridView(index);
              }),
        ),
      ],
    );
  }

  Container itemOfGridView(int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HomePhoto(user: _list[index]);
              }));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: _list.elementAt(index).urls!.regular!.toString(),
                placeholder: (context, url) => AspectRatio(
                  aspectRatio: _list[index].width! / _list[index].height!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                _list[index].user!.name!,
                style: const TextStyle(fontSize: 10.8),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: _list[index].user!.profileImage!.small!,
                  placeholder: (context, url) => const Image(
                    height: 30,
                    width: 30,
                    image: AssetImage("assets/images/img.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),),
                  icon: const Icon(Icons.more_horiz_outlined),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: Text("Download"),
                    ),
                    const PopupMenuItem(
                      child: Text("Share"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appbarCatigory() {
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Text(
          "All",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
