import 'package:flutter/material.dart';
import 'package:recette/components.dart';
import 'package:recette/screens/home_page.dart';
import 'package:recette/screens/startpage/start_page_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class StartPageView extends StatefulWidget {
  StartPageView({super.key});

  @override
  State<StartPageView> createState() => _StartPageViewState();
}

class _StartPageViewState extends State<StartPageView> {
  final controller = StartPageItems();
  final pagecontroller = PageController();
  bool veriflastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index)=>setState(()=>
          veriflastpage = controller.items.length - 1 ==index
          ),
            itemCount: controller.items.length,
            controller: pagecontroller,
            itemBuilder: (context, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("${controller.items[index].image}"),
                  SizedBox(height: 15,),
                  Text("${controller.items[index].title}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Text("${controller.items[index].descriptions}", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 18),),

                ],
              );
        }),
      ),
      bottomSheet: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: veriflastpage? getStartet(): Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextButton(
                onPressed: (){
                  pagecontroller.jumpTo(controller.items.length-1);
                },
                child: Text("Passer")
            ),

            // indicateur
            SmoothPageIndicator(
                controller: pagecontroller,
                count: controller.items.length,
                onDotClicked: (index)=> pagecontroller.animateToPage(
                    index, duration: Duration(microseconds: 600), curve: Curves.easeIn
                ),
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: primarycolor,
                  spacing: 15,
                ),
            ),

            TextButton(
                onPressed: (){
                  pagecontroller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                },
                child: Text("Suivant")
            ),

          ],
        ),
      ),
    );
  }
  Widget getStartet(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primarycolor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async{
          final pres = await SharedPreferences.getInstance();
          pres.setBool("zz", true);

          if(!mounted)return;

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },
        child: Text("Commencer", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
