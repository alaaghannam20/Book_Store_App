import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/home/data/repo/search_result_repo.dart';
import 'package:bookstore_app/features/home/presentation/widget/search_text.dart';
import 'package:bookstore_app/features/search/presentation/ui/widgets/search_result.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Products> searchResults = [];
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    searchHistory = SharedPrefsHelper.getSearchHistory();
  }

  void _handleSearch(List<Products> results, String keyword) {
    setState(() {
      searchResults = results;
    });
    if (keyword.isNotEmpty) {
      SharedPrefsHelper.addToSearchHistory(keyword);
      setState(() {
        searchHistory = SharedPrefsHelper.getSearchHistory();
      });
    }
  }

  void _searchFromHistory(String keyword) async {
    final results = await SearchResultRepo.fetchMatchingProducts(keyword);
    _handleSearch(results, keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 55, 12, 12),
            child: Column(
              children: [
                SearchText(
                  heightForSizeBox: 31,
                  widthForSizeBox: 39,
                  onResults: _handleSearch,
                ),
                SizedBox(height: 16),
                if (searchResults.isNotEmpty)
                  Expanded(
                    child: SearchResults(searchResults: searchResults),
                  )
                else
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView(
                        children: searchHistory
                            .map(
                              (query) => ListTile(
                                leading: Icon(Icons.history),
                                title: Text(query),
                                onTap: () => _searchFromHistory(query),
                              ),
                            )
                            .toList(),
                      ),
                    
                    ),
                     
                    
                  ),
                 SizedBox(height: 22),
              ],
            ),
          );
        },
      ),
    );
  }
}
