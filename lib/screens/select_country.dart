import 'package:flutter/material.dart';
import 'package:world_time/response/country_flags_response.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<dynamic> data = [];
  String _searchText = "";

  void getCountryFlags() async {
    CountryFlags response = CountryFlags();
    await response.getCountryFlags();
    setState(() {
      data = response.data;
    });
  }

  Widget countriesCard(String searchText) {
    List<dynamic> filteredList = searchText.isEmpty
        ? data
        : data
            .where((element) => element["name"]["official"]
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "/", arguments: {
                      "countryName": filteredList[index]["name"]["official"],
                      "flagUrl": filteredList[index]["flags"]["png"]
                    });
                  },
                  title: Hero(
                    tag: "country-${filteredList[index]["name"]["official"]}",
                    child: Text(
                      filteredList[index]["name"]["official"],
                      style: const TextStyle(color: Color(0xFF2C3333)),
                    ),
                  ),
                  leading: Hero(
                    tag: "flag-${filteredList[index]["name"]["official"]}",
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(filteredList[index]["flags"]["png"]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryFlags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCBE4DE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E8388),
        title: const Text("Choose a Country"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0E8388), width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffixIcon: CircleAvatar(
                      backgroundColor: const Color(0xFF2C3333).withAlpha(230),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                    ),
                    suffixIconConstraints:
                        BoxConstraints.tight(const Size(40, 40)),
                    border: InputBorder.none,
                    hintText: "Search Country",
                    hintStyle: TextStyle(
                      color: Color(0xFF2C3333).withAlpha(120),
                      fontWeight: FontWeight.w500,
                      decorationStyle: TextDecorationStyle.dotted,
                    )),
                style:
                    const TextStyle(fontSize: 16.0, color: Color(0xFF2C3333)),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            countriesCard(_searchText)
          ],
        ),
      ),
    );
  }
}
