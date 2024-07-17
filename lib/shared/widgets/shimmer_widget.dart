import 'package:barber_shop/shared/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerTypeBox{
  profile,
  listBox
}

class ShimmerWidget extends StatelessWidget {
  final ShimmerTypeBox typeBox;
  const ShimmerWidget({super.key, required this.typeBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height:  100 * 6,
        child: Shimmer.fromColors(
          baseColor: Colors.black.withOpacity(0.05),
          highlightColor: Colors.white.withOpacity(0.1),
          child: getShimmerWidget(typeBox)
        ),
      ),
    );
  }

  Widget getShimmerWidget(ShimmerTypeBox type){
    switch (type){
      case ShimmerTypeBox.profile:
        return _ProfileShimmerWidget();
      case ShimmerTypeBox.listBox:
        return _ListBox();
    }
  }

}



class _ProfileShimmerWidget extends StatelessWidget {
  const _ProfileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 95,
      child: Column(
        children: [
        Container(
          decoration: BoxDecoration(
              //color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(18)
          ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double innerHeight = constraints.maxHeight;
            double innerWidth = constraints.maxWidth;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: innerHeight * 0.65,
                    width: innerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: SizedBox(height: 80),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                        width: innerWidth * 0.40,
                        child: Image.asset(
                          Images.userAvatar,
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                )
              ],
            );
          },
        ),
      ),
          SizedBox(height: 10),
          _ProfileBoxWidget(),
          SizedBox(height: 10),
          _ProfileBoxWidget()
        ],
      ),
    );
  }
}

class _ProfileBoxWidget extends StatelessWidget {
  const _ProfileBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 95,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}



class _ListBox extends StatelessWidget {
  const _ListBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 110,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(18)
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return  SizedBox(height: 10);
        },
        itemCount: 5,
      );

  }
}


