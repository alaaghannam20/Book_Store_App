import 'dart:async';

import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/home/data/repo/search_result_repo.dart';
import 'package:flutter/material.dart';

class SearchText extends StatefulWidget {
  final double heightForSizeBox;
  final double widthForSizeBox;
  final Function(List<Products> , String) onResults;

  const SearchText({
    super.key,
    required this.heightForSizeBox,
    required this.widthForSizeBox,
    required this.onResults,
  });

  @override
  State<SearchText> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchText> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  final FocusNode _focusNode = FocusNode(); 

   @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {  
      if (_focusNode.hasFocus && _controller.text.isEmpty) {
        widget.onResults([], '');
      }
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), ()async {
      if (query.isNotEmpty) {
           final results = await SearchResultRepo.fetchMatchingProducts(query);
    widget.onResults(results, query);
      } else {
        widget.onResults([] , '');
      }
    });
  }
  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.hintTextColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: widget.heightForSizeBox,
              width: widget.widthForSizeBox,
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                onChanged: onSearchChanged,
                decoration: InputDecoration( 
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: 12,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic_none_rounded, color: AppColors.greyColor, size: 24),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.greyColor,
          ),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.pinkprimary, size: 20),
            onPressed: () {
              onSearchChanged(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}
