import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_app/models/user_model.dart';
import 'package:pinterest_app/services/db_service.dart';
import 'package:pinterest_app/services/http_service.dart';
import 'package:pinterest_app/services/log_service.dart';
import 'package:share_plus/share_plus.dart';

class HomePhoto extends StatefulWidget {
  User? user;
  static const String id = "home_photo";

  HomePhoto({Key? key, this.user}) : super(key: key);

  @override
  _HomePhotoState createState() => _HomePhotoState();
}

class _HomePhotoState extends State<HomePhoto> {
  bool isLoadPage = false;
  int selectedIndex = 0;
  int postsLength = 0;
  List<User> _list = [];
  List<String> listImage = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool isSave = false;


  void loadList(){
    setState(() {
      listImage = DBService.loadImageList();
    });
  }

  void storeImageList(){
    DBService.storeList(listImage);
  }

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
    super.initState();
    _userList();
    loadList();
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
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container (
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: CachedNetworkImage(
                        imageUrl: widget.user!.urls!.regular!.toString(),
                        placeholder: (context, url) => const Image(
                            image: AssetImage("assets/images/img.png")),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: ListTile(
                        title: Text(
                          widget.user!.user!.name!,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: widget.user!.user!.profileImage!.medium!,
                            height: 50,
                            width: 50,
                            placeholder: (context, url) => const Image(
                              image: AssetImage("assets/images/img.png"),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        subtitle: Text(
                          "${widget.user!.user!.totalLikes!.toString()} Followers",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        trailing: MaterialButton(
                          minWidth: 80,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(25),
                          ),
                          onPressed: () {},
                          color: Colors.grey.shade300,
                          child: Text(
                            "Follow",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    widget.user!.altDescription != null
                        ? Container(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, bottom: 15),
                            child: Text(
                              widget.user!.altDescription!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : SizedBox.shrink(),
                    widget.user!.description != null
                        ? Container(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, bottom: 15),
                            child: Text(
                              widget.user!.description!,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : SizedBox.shrink(),
                    ListTile(
                      leading: const Icon(
                        Icons.mode_comment_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(35),
                            ),
                            onPressed: () {},
                            color: Colors.grey.shade300,
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(35),
                            ),
                            onPressed: () {
                              isSave?null:listImage.add(widget.user!.urls!.regular!);
                              storeImageList();
                              setState(() {
                                isSave = true;
                              });
                            },
                            color: isSave? Colors.white:Colors.red.shade600,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: isSave? Colors.black: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          Share.share('${widget.user!.urls!.regular!}');
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "Share your feedback",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          widget.user!.user!.firstName![0],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 23),
                        ),
                      ),
                      title: Text(
                        widget.user!.user!.firstName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(widget.user!.likes!.toString(),style: TextStyle(color: Colors.black),),
                          SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Reply",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          widget.user!.user!.firstName![0],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 23),
                        ),
                      ),
                      title: GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                            ),
                            isDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  children: [
                                    Text("Add comment",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.w500),
                                ),
                                    TextFormField(
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Share what you like about this Pin",
                                        hintStyle: TextStyle(
                                            fontSize: 18, color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                    "Add a comment",
                        style: TextStyle(
                            fontSize: 16,color: Colors.grey),
                    ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                    itemCount: _list.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return itemOfGridView(index);
                    }),
              ),
            ],
          ),
        ),
      ),
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
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return HomePhoto(user: _list[index]);
              }));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: _list.elementAt(index).urls!.regular!.toString(),
                placeholder: (context, url) =>
                const Image(image: AssetImage("assets/images/img.png")),
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
