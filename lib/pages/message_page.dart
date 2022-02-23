import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest_app/models/collection_model.dart';
import 'package:pinterest_app/services/http_server_collection.dart';
import 'package:pinterest_app/services/log_service.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  static const String id = "message_page";

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool isLoadPage = false;
  int postsLength = 0;
  List<Collection> _list = [];
  bool isLoading = false;
  int _selected = 0;
  final _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  void _userList() async {
    setState(() {
      isLoading = true;
    });
    await Network1.GET(Network1.API_COLLECTION, Network1.paramsEmpty())
        .then((response) {
      Log.d(response!);
      _showResponse(response);
    });
  }

  void _showResponse(String response) {
    List<Collection> list = Network1.parseCollection(response);
    _list.clear();
    postsLength = list.length;
    setState(() {
      isLoading = false;
      _list = list;
    });
  }

  void _fetchPosts() async {
    int pageNumber = (_list.length ~/ postsLength + 1);
    String? response = await Network1.GET(
        Network1.API_COLLECTION, Network1.paramsPage(pageNumber));
    List<Collection> newPosts = Network1.parseCollection(response!);
    _list.addAll(newPosts);
    setState(() {
      isLoadPage = false;
    });
  }

  @override
  void initState() {
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
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = 0;
                    _pageController.animateToPage(_selected,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.fastLinearToSlowEaseIn);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _selected == 0 ? Colors.black : Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: _selected == 0 ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = 1;
                    _pageController.animateToPage(_selected,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeIn);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: _selected == 1 ? Colors.black : Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Message",
                    style: TextStyle(
                        color: _selected == 1 ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            _selected == 0
                ? IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        context: context,
                        builder: (context) {
                          return Container();
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.slider_horizontal_3,
                      color: Colors.black,
                    ))
                : SizedBox.shrink(),
          ],
        ),

        /// pageView
        body: Container(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selected = index;
              });
            },
            children: [
              /// Updates
              ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _list[index].title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GridView.custom(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                repeatPattern:
                                    QuiltedGridRepeatPattern.inverted,
                                pattern: [
                                  QuiltedGridTile(2, 2),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 2),
                                ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                (context, inde) => CachedNetworkImage(
                                  imageUrl: _list
                                      .elementAt(index)
                                      .previewPhotos!
                                      .elementAt(inde)
                                      .urls!
                                      .regular!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => AspectRatio(
                                    aspectRatio:
                                        _list[index].coverPhoto!.width! /
                                            _list[index].coverPhoto!.height!,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                childCount: 4,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _list[index].coverPhoto!.description != null
                            ? Text(
                                _list[index].coverPhoto!.description!,
                                style: const TextStyle(fontSize: 16),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }),

              /// Messages
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      SizedBox(
                        height: 95,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          "Share ideas with your friends",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey.shade200,
                        ),
                        child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 6),
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            hintText: "Search by name or email",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 45,
                                width: 45,
                                color: Colors.red.shade700,
                                child: Icon(
                                  Icons.people_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sync contacts",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: FaIcon(
                      FontAwesomeIcons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
