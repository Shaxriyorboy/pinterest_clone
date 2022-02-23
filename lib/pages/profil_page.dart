import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_app/services/db_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  List<String> list = [];
  bool isPress = false;

  void _loadList() {
    setState(() {
      list = DBService.loadImageList();
    });
  }

  void _storeList()async{
    await DBService.storeList(list);
  }

  @override
  void initState() {
    _loadList();
    super.initState();
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
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {  },
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                )),

            ///bottom sheet
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 260,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              margin:
                                  EdgeInsets.only(top: 10, left: 10, bottom: 5),
                            ),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                    context: context, builder: (context){
                                  return settingBottomSheet(context);
                                });
                              },
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Edit public profile",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Copy profile link",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                minWidth: 60,
                                height: 50,
                                color: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close"),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade200,
                  child: Text(
                    "S",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Shaxriyor",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(
                  "@shaxriyortursunaliyev146",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0 followers •",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      " 0 following",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      alignment: Alignment.centerLeft,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade200,
                      ),
                      child: TextField(
                        onTap: () {},
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          setState(() {});
                        },
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
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.add,
                        color: Colors.grey.shade900,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              list.isNotEmpty
                  ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: MasonryGridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: (){
                              setState(() {
                                isPress = true;
                              });
                              print("sa");
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: DBService.loadImageList()[index],
                                    placeholder: (context, url) => const Image(
                                        image:
                                            AssetImage("assets/images/img.png")),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                PopupMenuButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),),
                                    icon: const Icon(Icons.more_horiz_outlined),
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        onTap: (){
                                          list.remove(list.elementAt(index));
                                          _storeList();
                                          setState(() { });
                                        },
                                      ),
                                    ],
                                )
                              ],
                            ),
                          );
                        }),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingBottomSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              toolbarHeight: 60,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              ),
              leading: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, ProfilePage.id);
                },
                icon: Icon(
                  CupertinoIcons.chevron_back,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Container(
                height: 40,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Personal information",
                  style: TextStyle(fontSize: 16),
                )),
            ListTile(
              onTap: () {},
              title: Text(
                "Account settings",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Permissions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Privacy & data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Public profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Home feed tuner",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Actions",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Add account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Log out",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Support",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Get help",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.arrow_up_right,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "Terms & Privacy",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.arrow_up_right,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "About",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

