import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fornature/pages/base_map.dart';

class CustomSearchDelegate extends SearchDelegate {
  var suggestion = ["빛바람"];
  List searchResult = List();
  DocumentSnapshot chosen;
  //List<DocumentSnapshot> shops = [];
  //List<DocumentSnapshot> filteredshops = [];

  search(String query) {
    if (query == "") {
      filteredshops = shops;
    } else {
      List shopSearch = shops.where((shopSnap) {
        String shopName = shopSnap.id;
        return shopName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredshops = shopSearch;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchResult.clear();
    if (query == "") {
      searchResult = shops;
    } else {
      searchResult = shops.where((shopSnap) {
        return shopSnap.id.contains(query);
      }).toList();
    }
    chosen = searchResult[0];
    double lat = chosen['location'].latitude;
    double long = chosen['location'].longitude;
    print('lat is: $lat, long is $long');
    //filteredshops = search(query);
    //allNames.where((element) => element.startsWith(query)).toList();

    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          scrollDirection: Axis.vertical,
          children: List.generate(searchResult.length, (index) {
            DocumentSnapshot doc = searchResult[index];
            var item = doc.id;
            return Card(
              color: Colors.white,
              child: Container(padding: EdgeInsets.all(16), child: Text(item)),
            );
          })),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    //final suggestionList = query.isEmpty ? suggestion : search(query);
    //filteredshops = search(query);
    print('query is: $query');
    for (int i = 0; i < shops.length; i++) {
      print('shop id $i is  ${shops[i].id}');
    }
    List shopSearch;
    if (query == "") {
      shopSearch = shops;
    } else {
      shopSearch = shops.where((shopSnap) {
        print('shopSnap id: ${shopSnap.id}');
        return shopSnap.id.contains(query);
      }).toList();
    }

    //filteredshops = query.isEmpty ? suggestion : search(query);
    print('filtered shops num : ${shopSearch.length}');

    //print('shops num : ${shops.length}');
    return ListView.builder(
      itemCount: shopSearch.length,
      itemBuilder: (context, index) {
        DocumentSnapshot doc = shopSearch[index];
        return ListTile(
          //DocumentSnapshot doc = filteredshops[index];
          onTap: () {
            //if (query.isEmpty) {
            //  query = doc.id;
            //}
            placename = doc.id;
            lat = doc['location'].latitude;
            long = doc['location'].longitude;
            //phone = doc.get('number') as String;
            //time = doc.get('time') as String;
            print('lat is: $lat, long is $long');
            /*
            tmpcat = List.from(doc['category']);
            for (int i = 0; i < tmpcatbool.length; i++) {
              tmpcatbool[i] = false;
            }
            for (int i = 0; i < tmpcat.length; i++) {
              if (tmpcat[i] == "소분") {
                tmpcatbool[0] = true;
              } else if (tmpcat[i] == "공방") {
                tmpcatbool[1] = true;
              } else if (tmpcat[i] == "리필") {
                tmpcatbool[2] = true;
              } else if (tmpcat[i] == "카페") {
                tmpcatbool[3] = true;
              }
            }
            */
            searched = true;
            close(context, null);
          },
          leading: Icon(query.isEmpty ? Icons.history : Icons.search),
          title: RichText(
              text: TextSpan(
            text: doc.id,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //children: [
            //TextSpan(
            //text: shopSearch[index].substring(query.length).toString(),
            //style: TextStyle(color: Colors.black),
            //)
            //]
          )),
        );
      },
    );
  }
}
