import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kids_life_flutter/provider/farm_stay_cart_provider.dart';
import 'package:kids_life_flutter/provider/farm_stay_provider.dart';
import 'package:kids_life_flutter/ui/farm_stay/farm_stay_details_page.dart';
import 'package:kids_life_flutter/ui/main_page/home_ui/navigation_drawer/navigation_drawer.dart';
import 'package:kids_life_flutter/ui/utils/custom_class.dart';
import 'package:kids_life_flutter/ui/utils/icons.dart';
import 'package:provider/provider.dart';

import 'farm_stay_list_tile.dart';

class FarmStayHomeUi extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const FarmStayHomeUi({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<FarmStayHomeUi> createState() => _FarmStayHomeUiState();
}

class _FarmStayHomeUiState extends State<FarmStayHomeUi> {
  late DateTimeRange? dateTimeRange;
  String? fromDate;
  String? toDate;
  int? guests;

  String getFrom(){
    if(dateTimeRange == null){
      fromDate = "--/--/--";
      return fromDate!;
    }else{
      fromDate = DateFormat('dd/MM/yyyy').format(dateTimeRange!.start);

      return fromDate!;
    }
  }

  String getTo() {
    if (dateTimeRange == null) {
      toDate = "--/--/--";
      return toDate!;
    } else {
      toDate = DateFormat('dd/MM/yyyy').format(dateTimeRange!.end);
      return toDate!;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeRange = null;
  }

  @override
  Widget build(BuildContext context) {
    var farmStayProvider = Provider.of<FarmStayProvider>(context);
    final theme = Theme.of(context);
    LinearGradient farmStayAppBar = const LinearGradient(colors: [Color(0xffFFB802), Color(0xffFFDA93)]);



    return Scaffold(
      // drawer: const NavigationDrawer(),

      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, theme),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Container(
              height: 50,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(2, 4),
                    blurRadius: 4,
                    spreadRadius: 0)
              ]),
              child: buildSearchBar(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: farmStayAppBar,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPrimaryInfoTablet(context, 'From', CustomIcons.calender, Colors.green),
                buildPrimaryInfoTablet(context, 'To', CustomIcons.calender, Colors.red),
                buildPrimaryInfoTablet(context, 'Guests', CustomIcons.people, Colors.purple)
              ],
            ),
          ),
          Flexible(
            flex: 23,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                  constraints: BoxConstraints(
                      maxHeight: double.infinity,
                      minHeight: MediaQuery.of(context).size.height),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: widget.snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                              onTap: () {
                                try{
                                  String docId = widget.snapshot.data!.docs[index].id;
                                  var dealStream = farmStayProvider.fetchFarmStayDeals(docId);
                                  farmStayProvider.updateDate(widget.snapshot.data!.docs[index].id,fromDate!, toDate!, guests!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FarmStayDetails(
                                            deals: dealStream,
                                            farmStaySnapshot: widget.snapshot.data!.docs[index],
                                            fromDate:fromDate,
                                            toDate:toDate,
                                            guests:guests,
                                          )));
                                }catch(e){
                                  pickDatesErrorDialog(context, 'Pick dates and number of guests', 'Pick out your dates before moving forward');
                                }

                              },
                              child: FarmStayListTile(
                                  snapshot: widget.snapshot.data!.docs[index],isAddedToCart: false,)),
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, ThemeData theme) {
    LinearGradient farmStayAppBar =
        const LinearGradient(colors: [Color(0xffFFB802), Color(0xffFFDA93)]);
    return AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              gradient: farmStayAppBar,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
        title: Text(
          "Green Trench",
          style: theme.textTheme.bodyText1,
        ),
        centerTitle: true,

        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 20.0, top: 10),
        //       child: IconButton(
        //         icon: Icon(
        //           CustomIcons.hamburger,
        //           size: 30,
        //           color: Theme.of(context).scaffoldBackgroundColor,
        //         ),
        //         onPressed: () {
        //           return Scaffold.of(context).openDrawer();
        //         },
        //       ),
        //     );
        //   },
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {},
              child: Icon(
                Icons.notifications_none,
                size: 30,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {},
              child: Icon(
                Icons.account_circle,
                size: 30,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ]);
  }

  TextField buildSearchBar() {
    return TextField(
      showCursor: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          fillColor: const Color(0xffE5E5E5),
          filled: true,
          prefixIcon: Icon(
            CustomIcons.search,
            color: Colors.black.withOpacity(0.33),
          ),
          hintText: 'Search anything',
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.37)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(style: BorderStyle.none))),
      onChanged: (String query) {},
    );
  }

  Widget buildPrimaryInfoTablet(BuildContext context, String text, IconData icon, Color color) {
    final transparentGradient = LinearGradient(colors: [
      const Color(0xffE8E8E8).withOpacity(0.6),
      const Color(0xffFFFFFF).withOpacity(0.42)
    ]);

    List<int> noOfGuests = List<int>.generate(15, (index) => index+1);

    return InkWell(
      onTap: () {
        if (text == 'From') {
          pickDateRange(context);
        } else if (text == 'To') {
          pickDateRange(context);
        } else {
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
            gradient: transparentGradient,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const VerticalDivider(
                width: 10,
                color: Colors.grey,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w200),
                  ),
                  if (text == "Guests")  Expanded(
                    child: DropdownButton<int>(
                      value: guests,
                      items: noOfGuests.map(buildMenuItem).toList(),
                      onChanged: (value){
                        setState(() {
                          guests = value;
                        });
                      },

                    ),
                  )
                  else if(text=='From')  Text(getFrom(),
                          style: const TextStyle(fontSize: 12, color: Colors.black))
                  else Text(getTo(),
                        style: const TextStyle(fontSize: 12, color: Colors.black))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().day),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDateRange: initialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              bodyText2: GoogleFonts.mavenPro(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.height * 0.8,
                child: child,
              )
            ],
          ),
        );
      },

    );

    if(newDateRange==null) return;
    setState(() {
      dateTimeRange = newDateRange;
    });

  }

  Widget pickNoOfGuests(List<int> noOfGuests) {
    return DropdownButton<int>(
      value: guests,
        items: noOfGuests.map(buildMenuItem).toList(),
      onChanged: (value){
          setState(() {
            guests = value;
          });
      },
    );
  }

  DropdownMenuItem<int> buildMenuItem(int item){
    return DropdownMenuItem<int>(
        value: item,
        child: Text(item.toString(),style: Theme.of(context).textTheme.subtitle1,));
  }

  pickDatesErrorDialog(BuildContext context, String title, String subtitle,) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: Center(child: Text(title))),
                ),
              ],
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(subtitle),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              )
            ],
          );
        });
  }
}
