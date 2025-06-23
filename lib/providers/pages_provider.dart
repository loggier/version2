import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';

//Controlar la pagina con pageView y el bottomNavbar
class PagesProvider extends ChangeNotifier{
  final _controller = PageController(initialPage: 0);
  final GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  PageController get pageController => _controller;
  GlobalKey<ConvexAppBarState> get appBarKey => _appBarKey;
  
  bool showActions = true;
  String title = S.current.labelMapas;
  int actionIndex = 0;  
  int currentPage = 0;

  //Cambiar pagina
  animateToPage(int index){
    currentPage = index;
    // _controller.jumpToPage(index);
    _controller.animateToPage(
      index, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeInOut
    );
    _appBarKey.currentState?.animateTo(index);
  }

  bool get getShowActions => showActions;
  String get getTitle => title;
  int get getActionIndex => actionIndex;
  int get getCurrentPage => currentPage;

  //Cambiar de pagina y controlar el appbar dinamicamente
  appBarController(int index){
    switch (index) {
      case 0:
        title = S.current.labelMapas;//Titulo del appbar
        showActions = true;//Mostrar acciones ¿?
        actionIndex = 0;//Index de la pagina
        notifyListeners();
        break;
      case 1:
        title = S.current.labelDispositivos;    
        showActions = true;
        actionIndex = 1;
        notifyListeners();    
        break;
      case 2:
        title = S.current.labelAlertas;
        showActions = true;  
        actionIndex = 2;
        notifyListeners();      
        break;
      default:
        title = S.current.labelHistorial;
        showActions = false;
        notifyListeners();
    }
  }
}