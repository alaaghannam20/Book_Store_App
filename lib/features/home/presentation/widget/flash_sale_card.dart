import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class FlashSaleCard extends StatelessWidget {
  const FlashSaleCard({super.key , required this.flashSaleBooks , required this.scrollPhysics});

    final List<Products> flashSaleBooks;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(height: 16), 
      itemCount: flashSaleBooks.length,
      physics: scrollPhysics,
      shrinkWrap: true,
      itemBuilder: (context , index){
        final book = flashSaleBooks[index];
        final double progress = (100 - book.discount) / 100;
        final double oldPrice = book.price ?? 0;
        final double newPrice = book.priceAfterDiscount;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: AppColors.flashColor
          ),
          child: Row(
            children: [
              InkWell (
                onTap: (){
                  Navigator.pushNamed(context, Routes.bookDetailsScreen , arguments: book.id);
                },
                child: ClipRRect(
                  child: Image.network(book.image , width: 93 , height: 131, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.name , 
                    style: TextStyle(
                       fontFamily: 'Open Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                    ),
                    ),
                    SizedBox(height: 4,),
                         Row(
                  children: [
                    Text(
                      'Author:',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      " ${book.category}",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 8,
                ),
                LinearProgressIndicator(
                   value: progress,
                      color:AppColors.amberColor,
                      backgroundColor: AppColors.greyColor,
                      minHeight: 6,
                ),
                SizedBox(height: 9,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                           "${book.stock} books left",
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Color(0x80FFFFFF),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.starsColor, size: 16),

                            Text(
                               "4.5",
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("\$$oldPrice" ,
                            style: TextStyle(
                                 fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0x80FFFFFF),
                            ),
                            ),
                            SizedBox(width: 4,),
                              Text("\$$newPrice" ,
                            style: TextStyle(
                                 fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: AppColors.whiteColor,
                            ),
                            ),
                          ],
                        ),
                           Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.pinkprimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart,
                                color: AppColors.whiteColor, size: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        );
        
      }, 

      
      );
  }
}