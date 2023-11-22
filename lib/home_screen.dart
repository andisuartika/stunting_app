import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:stunting/models/resource_model.dart';
import 'package:stunting/providers/auth_provider.dart';
import 'package:stunting/providers/posyandu_provider.dart';
import 'package:stunting/services/resource_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_posyandu_item.dart';

import 'models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResourceModel? resource = ResourceModel(balita: 0, ibu: 0);

  @override
  void initState() {
    // TODO: implement initState
    getResource();
    super.initState();
  }

  getResource() async {
    var res = await ResourceService().getInformation();
    setState(() {
      resource = res;
    });
  }

  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    PosyanduProvider posyandus = Provider.of<PosyanduProvider>(context);
    // HEADER
    Widget header() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                    child: Image.asset('assets/doctor_image.png', width: 60)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name!,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Text(
                        'Puskesmas Sukasada 1',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFECF0F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.search_normal,
                    color: primaryTextColor,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      // controller: searchController,
                      onTap: () {},

                      decoration: InputDecoration.collapsed(
                        hintText: 'Search ...',
                        hintStyle: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // INFO
    Widget information() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: double.infinity,
              height: 135,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/doctor_banner.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "12",
                    style: whiteTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    "Tenaga Medis",
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: 135,
                  width: 155,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg_count.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource!.ibu.toString(),
                        style: whiteTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Calon Ibu",
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: 135,
                  width: 155,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg_count.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource!.balita.toString(),
                        style: whiteTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Balita",
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    // POSYANDU
    Widget Posyandu() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Posyandu terdekat",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: posyandus.posyandu
                  .map(
                    (posyandu) => CustomPosyanduItem(
                        posyanduName: posyandu.namaPosyandu.toString(),
                        alamat: posyandu.desa.toString(),
                        tenagaMedis: '7'),
                  )
                  .toList(),
            )
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: 5,
            //       itemBuilder: (BuildContext context, int index) {
            //         return ListTile(
            //             leading: const Icon(Icons.list),
            //             trailing: const Text(
            //               "GFG",
            //               style: TextStyle(color: Colors.green, fontSize: 15),
            //             ),
            //             title: Text("List item $index"));
            //       }),
            // ),
            // CustomPosyanduItem(
            //   posyanduName: 'Puskesmas Sukasada 1',
            //   alamat: 'Jalan Jelantik Gingsir',
            //   tenagaMedis: '3',
            // ),
            // CustomPosyanduItem(
            //   posyanduName: 'Puskesmas Sukasada 2',
            //   alamat: 'Jalan Pratu Praupan',
            //   tenagaMedis: '2',
            // ),
            // CustomPosyanduItem(
            //   posyanduName: 'Puskesmas Sukasada 3',
            //   alamat: 'Jalan Raya Singaraja - Denpasar',
            //   tenagaMedis: '1',
            // ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              header(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      information(),
                      Posyandu(),
                    ],
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
