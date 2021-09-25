import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.wand_stars_inverse,
                  color: Colors.yellow,
                  size: 19,
                ),
                const SizedBox(width: 10),
                Text(
                  'Trending',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ],
            ),
            Container(
              width: size.width,
              height: 45,
              margin: const EdgeInsets.symmetric(vertical: 27),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.black.withOpacity(.6),
                    size: 20,
                  ),
                  const SizedBox(width: 7),
                  const Text(
                    'Search',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Container(
              height: size.width,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xffD7F9FB),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            Container(
              width: 80,
              margin: const EdgeInsets.only(top: 16, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(.08),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(.08),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(.08),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '#c4d',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '2.4m',
                        style: TextStyle(),
                      ),
                      Icon(
                        CupertinoIcons.forward,
                        size: 19,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 150,
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffE3D6D5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffE3D6D5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xffE3D6D5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
