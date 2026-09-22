import 'package:myinoface/features/all_classes/data/models/search_model.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SearchEleve extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'clear'.tr,
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'back'.tr,
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('no_result_found'.tr),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<SearchModel>(
      future: query == "" ? null : appUtils.fetchEleve(query),
      builder: (context, snapshot) => query == ''
          ? const SizedBox.shrink() : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data!.eleves[index].nom ?? ''),
                    onTap: () {
                      close(context, snapshot.data!.eleves[index].nom ?? '');
                    },
                  ),
                  itemCount: snapshot.data!.eleves.length,
                ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
