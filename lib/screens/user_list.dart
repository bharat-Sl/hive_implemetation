import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jethi_tech_solutions_task1/components/modal_bottom_custom.dart';
import 'package:jethi_tech_solutions_task1/constants/userdata.dart';
import 'package:jethi_tech_solutions_task1/models/user_model.dart';
import 'package:jethi_tech_solutions_task1/screens/user_detail.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> users = [];
  bool loading = false;

  getData() async {
    var box = await Hive.openBox('myBox');
    print(box.path);
    if (box.isEmpty) {
      usersData[0]["users"]!.forEach((element) {
        UserModel tempUser = UserModel.fromJson(element);
        box.add(tempUser);
      });
    } else {
      box.values.forEach((element) {
        users.add(element);
      });
      print(box.keys);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(colors: [
          Color.fromRGBO(58, 66, 86, 1.0),
          Color.fromRGBO(58, 66, 86, 0.6),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Welcome!",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                user: users[index],
              );
            }),
      ),
    );
  }
}

class ListTile extends StatefulWidget {
  UserModel user;

  ListTile({Key? key, required this.user}) : super(key: key);

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.user.isLoggedIn
          ? () async {
              widget.user = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailPage(
                        user: widget.user,
                      )));
              setState(() {});
            }
          : () async {
              try {
                widget.user = await getModalBottomSheet(context, widget.user);
                setState(() {});
                if (widget.user.isLoggedIn) {
                  widget.user =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserDetailPage(
                                user: widget.user,
                              )));
                }
                setState(() {});
              } catch (e) {
                print(e);
              }
            },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 75, 96, .9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey[900]!, blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            widget.user.isLoggedIn ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.user.isLoggedIn ? "logged In" : "Logged out",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () async {
                if (widget.user.isLoggedIn) {
                  var box = await Hive.openBox('myBox');
                  widget.user.isLoggedIn = !widget.user.isLoggedIn;
                  widget.user.age = null;
                  widget.user.gender = null;
                  box.putAt(int.parse(widget.user.id) - 1, widget.user);
                  setState(() {});
                } else {
                  try {
                    widget.user =
                        await getModalBottomSheet(context, widget.user);
                    setState(() {});
                    if (widget.user.isLoggedIn) {
                      widget.user =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserDetailPage(
                                    user: widget.user,
                                  )));
                    }
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Container(
                width: 100,
                height: 80,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[900]!, blurRadius: 4),
                  ],
                ),
                child: Center(
                  child: !widget.user.isLoggedIn
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              ("Login"),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.arrow_forward,
                            ),
                          ],
                        )
                      : const Text(
                          ("Logout"),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
