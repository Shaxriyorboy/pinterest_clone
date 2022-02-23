import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_app/models/user_model.dart';
import 'package:pinterest_app/pages/search_photo_page.dart';
import 'package:pinterest_app/services/http_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String id = "search_page";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoadPage = false;
  int pageNumber = 1;
  int selectedIndex = 0;
  int postsLength = 1;
  List<User> _list = [];
  bool isLoading = false;
  bool press = false;
  final ScrollController _scrollController = ScrollController();
  final _textController = TextEditingController();

  void _fetchPosts() async {
    dynamic response = await Network.GET(Network.API_LIST_SEARCH,
        Network.paramsSearch(pageNumber, _textController.text));
    List<User> newPosts = Network.parseSearchParse(response);
    if (pageNumber == 1) {
      setState(() {
        _list = newPosts;
        isLoading = true;
      });
    } else {
      _list.addAll(newPosts);
    }
    setState(() {
      isLoadPage = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadPage = true;
          pageNumber++;
        });
        _fetchPosts();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                alignment: Alignment.centerLeft,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.shade300,
                ),
                child: TextField(
                  onTap: (){
                    setState(() {
                      press = true;
                    });
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _fetchPosts();
                    setState(() {
                      _list.clear();
                      press = false;
                    });
                  },
                  controller: _textController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    hintText: "Search by name or email",
                  ),
                ),
              ),
            ),
            press?Expanded(
              flex: 1,
              child: TextButton(
                onPressed: (){
                  _textController.clear();
                },
                child: Text("Cancel",style: TextStyle(fontSize: 18,color: Colors.grey.shade900),),
              ),
            ):SizedBox.shrink(),
          ],
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

  ///GridView Item
  Container itemOfGridView(int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return SearchPhoto(
                  user: _list[index],
                  search: _textController.text,
                  index: pageNumber,
                );
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
                      borderRadius: BorderRadius.circular(15)),
                  icon: const Icon(Icons.more_horiz_outlined),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: Text("Download"),
                    ),
                    const PopupMenuItem(
                      child: Text("Save"),
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
}
