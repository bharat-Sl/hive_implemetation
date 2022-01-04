import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jethi_tech_solutions_task1/models/user_model.dart';

import 'numberpicker.dart';

getModalBottomSheet(BuildContext context, UserModel user) {
  String sex = "Male";
  int age = 10;
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: const EdgeInsets.all(23),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(58, 66, 86, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20,
                        offset: Offset(0, -10))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Center(
                    child: Text(
                      "You are ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              sex = "Male";
                            });
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[900]!, blurRadius: 4),
                              ],
                              color: sex != "Male"
                                  ? const Color.fromRGBO(78, 86, 106, 1.0)
                                  : Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.male,
                                  size: 60,
                                  color: sex == "Male"
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      color: sex == "Male"
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              sex = "Female";
                            });
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[900]!, blurRadius: 4),
                              ],
                              color: sex != "Female"
                                  ? const Color.fromRGBO(78, 86, 106, 1.0)
                                  : Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.female,
                                  size: 60,
                                  color: sex == "Female"
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      color: sex == "Female"
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              sex = "Others";
                            });
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[900]!, blurRadius: 4),
                              ],
                              color: sex != "Others"
                                  ? const Color.fromRGBO(78, 86, 106, 1.0)
                                  : Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.transgender,
                                  size: 60,
                                  color: sex == "Others"
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                Text(
                                  "Others",
                                  style: TextStyle(
                                      color: sex == "Others"
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      "How old are you?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: NumberPicker(
                      value: age,
                      minValue: 0,
                      maxValue: 100,
                      itemHeight: 60,
                      axis: Axis.horizontal,
                      textStyle: TextStyle(color: Colors.white),
                      onChanged: (value) => setState(() => age = value),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      var box = await Hive.openBox('myBox');
                      user.isLoggedIn = !user.isLoggedIn;
                      user.age = age.toString();
                      user.gender = sex;
                      box.putAt(int.parse(user.id) - 1, user);
                      setState(() {});
                      Navigator.of(context).pop(user);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey[900]!, blurRadius: 4),
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
