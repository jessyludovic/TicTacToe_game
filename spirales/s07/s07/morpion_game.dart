// Inspiré par Educ_memory_game_s02 de Dzenan Ridjanovic
// https://github.com/dzenanr/educ_memory_game/tags

import'dart:html';
import 'dart:math'; 
import 'dart:isolate';

part 'model/case.dart';
part 'view/Tableau.dart';
part 'model/cellule.dart';


void main() {
  // Get a reference to the canvas.
  CanvasElement canvas = document.query('#canvas');
  new Tableau(canvas, new Case(3));
  
}


