import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jethi_tech_solutions_task1/models/user_model.dart';

class UserDetailPage extends StatefulWidget {
  final UserModel user;
  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
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
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.chevron_left,
              color: Colors.white.withOpacity(0.8),
              size: 38,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Text(
                    widget.user.name.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        fontSize: 50),
                  ),
                ),
                Positioned(
                  top: -40,
                  right: -20,
                  child: Text(
                    widget.user.name.toString(),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.16),
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                ),
              ]),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Row(
                        children: [
                          const Text(
                            "Age",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            widget.user.age.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35,
                      child: Row(
                        children: [
                          const Text(
                            "Gender",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            widget.user.gender.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                // var box = await Hive.openBox('myBox');
                // user.isLoggedIn = !user.isLoggedIn;
                // user.age = age.toString();
                // user.gender = sex;
                // box.putAt(int.parse(user.id) - 1, user);
                // setState(() {});
                // Navigator.of(context).pop(user);
                var box = await Hive.openBox('myBox');
                UserModel user = widget.user;
                user.isLoggedIn = !user.isLoggedIn;
                user.age = null;
                user.gender = null;
                box.putAt(int.parse(user.id) - 1, user);
                Navigator.of(context).pop(user);
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[900]!, blurRadius: 4),
                  ],
                  color: Colors.white,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        Icons.logout,
                      ),
                    ],
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
