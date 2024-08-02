import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/persistence.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/custom_button.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: customColor(context),
                      child: ClipOval(
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: secondaryColor(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Habib Yusuf",
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontSize: 20,
                      color: customColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Subscriber",
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontSize: 12,
                      color: customColor(context),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
            SliverList.builder(
              itemCount: listsData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CardList(
                    listData: listsData[index],
                    itemCount: listsData.length,
                    index: index,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 15,
                ),
                child: CustomButton(
                  onPress: () {},
                  text: "Sign Out",
                  height: 50,
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  const CardList({
    super.key,
    required this.listData,
    required this.itemCount,
    required this.index,
  });
  final List<Map<String, dynamic>> listData;
  final int itemCount;
  final int index;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool _isSwitched = false;

  @override
  void initState() {
    runBio();
    super.initState();
  }

  runBio() async {
    final bio = await TokenPersistence().getBioAuth() ?? false;
    setState(() {
      _isSwitched = bio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: widget.listData.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = widget.listData[index];
            Widget? checkTrailing() {
              if (item["title"] == listbio) {
                return Switch(
                  value: _isSwitched,
                  trackOutlineColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                  onChanged: (value) async {
                    setState(() {
                      _isSwitched = value;
                    });
                    if (_isSwitched) {
                      final bioAuthVal = await authBio();
                      setState(() {
                        _isSwitched = bioAuthVal;
                      });

                      await TokenPersistence().setBioAuth(bioAuthVal);

                      return;
                    }
                    await TokenPersistence().setBioAuth(_isSwitched);
                    return;
                  },
                );
              }
              if (item["trailing"] && item["title"] != listbio) {
                return const Icon(Icons.keyboard_arrow_right);
              }
              return null;
            }

            return ListTile(
              onTap: () {},
              title: Text(widget.listData[index]["title"]),
              leading: Icon(
                widget.listData[index]["leading"],
                size: 20,
              ),
              trailing: checkTrailing(),
            );
          },
        ),
        if (widget.index != widget.itemCount - 1)
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Divider(),
          ),
      ],
    );
  }
}
