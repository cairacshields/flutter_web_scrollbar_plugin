# flutter_web_scrollbar

  

A flutter web plugin for adding a customizable scrollbar to your web project.
![Scroll Bar Web](https://i.ibb.co/D7SG7KG/ezgif-com-crop.gif)
## Usage
To use this plugin add `flutter_web_scrollbar` as [a dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).
  
Adding the scrollbar to your webpage requires a few mandatory steps: 

 1. The content of your page must be the child of a Scrollable Widget (i.e: `SingleChildScrollView` 
 2. The scrollable widget and the FlutterWebScrollbar ***must*** be children in a parent `Stack`
 3. The scrollable widget ***must*** be listed first in the `Stack`
 4. The scrollable widget must have a  `ScrollController` attached to it 
 5. The FlutterWebScrollbar must receive a callBack function that accepts a `DragUpdateDetails` as a parameter. 

**Example** 

```
import 'package:flutter/material.dart';  
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';  
  
class LandingPage extends StatefulWidget {  
  LandingPage({Key key}) : super(key: key);  
  @override  
  State<StatefulWidget> createState() {  
    return _LandingPageState();  
  }  
}  
  
class _LandingPageState extends State<LandingPage> {  
  ScrollController _controller;  
  
  @override  
  void initState() {  
      //Initialize the  scrollController  
      _controller = ScrollController();  
      super.initState();  
  }  
  
  void scrollCallBack(DragUpdateDetails dragUpdate) {  
    setState(() {  
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.  
       _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
  
    return Scaffold(  
      backgroundColor: Colors.white,  
      body: Stack(  
        children: [  
          Container(  
            child: SingleChildScrollView(  
              //Assign the controller to my scrollable widget  
              controller: _controller,  
              child: Column(  
                children: [  
                  Container(  
                    height: MediaQuery.of(context).size.height,  
                    width: MediaQuery.of(context).size.width,  
                    color: Colors.black,  
                  ),  
                  Container(  
                    height: MediaQuery.of(context).size.height,  
                    width: MediaQuery.of(context).size.width,  
                    color: Colors.red,  
                  ),  
                  Container(  
                    height: MediaQuery.of(context).size.height,  
                    width: MediaQuery.of(context).size.width,  
                    color: Colors.green,  
                  ),  
                  Container(  
                    height: MediaQuery.of(context).size.height,  
                    width: MediaQuery.of(context).size.width,  
                    color: Colors.blue,  
                  ),  
                ],  
              ),  
            ),  
          ),  
  
  
          FlutterWebScroller(  
            //Pass a reference to the ScrollCallBack function into the scrollbar  
            scrollCallBack,  
  
            //Add optional values  
            scrollBarBackgroundColor: Colors.white,  
            scrollBarWidth: 20.0,  
            dragHandleColor: Colors.red,  
            dragHandleBorderRadius: 2.0,  
            dragHandleHeight: 40.0,  
            dragHandleWidth: 15.0,  
          ),  
        ],  
      ),  
    );  
  }  
}
````

Things to note about the above code:
- 
- Inside of our `scrollCallBack` function, we're updating the `ScrollController` that is attached to our scrollable widget. It's important to note that in the example, we are using a value of 3.5 to represent the theoretical height of our page content. The theoretical height of your page content may be different. For example, if you have to full height container as your content, you may want to use 2 rather than 3.5. Getting this value as correct as possible plays a big role in how accurate your scrolling will be. 
- Visit the repository [here](https://github.com/cairacshields/flutter_web_scrollbar_plugin) to submit issue reports and request changes
- If you'd like to help with the upkeep for the plugin, email me at `caira102797@gmail.com`

        
<a href="https://www.buymeacoffee.com/cairashields" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Pizza" style="height: 51px !important;width: 217px !important;" ></a>      
