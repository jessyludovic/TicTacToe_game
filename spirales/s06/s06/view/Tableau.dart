// Inspiré par Educ_memory_game_s02/Board de Dzenan Ridjanovic
// https://github.com/dzenanr/educ_memory_game/tags
class Tableau {

  // The board is drawn every interval in ms.
  static const int interval = 8;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num width;
  num height;
  var test;
  List casejouee = [0,1,2,3,4,5,6,7,8];
  var check_joueur = new List() ;
  var check_ordi = new List() ;
  var tabtest_o = new List() ;
  var tabtest_j = new List() ;
  List triosgagnants = [[0,1,2],[0,3,6],[0,4,8],[0,2,1],[0,6,3],[0,8,4],[1,0,2],[3,0,6],[4,0,8],[1,2,0],[3,6,0],[4,8,0],[2,0,1],[6,0,3],[8,0,4],[2,1,0],[6,3,0],[8,4,0],[3,4,5],[1,4,7],[2,4,6],[3,5,4],[1,7,4],[2,6,4],[4,3,5],[4,1,7],[4,2,6],[4,5,3],[4,7,1],[4,6,2],[5,3,4],[7,1,4],[6,2,4],[5,4,3],[7,4,1],[6,4,2],[6,7,8],[2,5,8],[6,8,7],[2,8,5],[7,6,8],[5,2,8],[7,8,6],[5,8,2],[8,6,7],[8,2,5],[8,7,6],[8,5,2]];
  var temp;
  

  Case cases;

  Tableau(this.canvas, this.cases) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;

    document.query('#canvas').on.mouseDown.add(_onMouseDown);
    // Draw every interval in ms.
    document.window.setInterval(draw, interval);
   
  }

  void _clear() {
    context.clearRect(0, 0, width, height);
  }

  void _border() {
    context.rect(0, 0, width, height);
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur    = 5;
    context.shadowColor   = '#aea4f2';
    context.strokeStyle = '#ffffff';
    context.stroke();
  }

  void _lines() {
    var gap = height / cases.taille;
    var x, y;
    for (var i = 1; i < cases.taille; i++) {
      x = gap * i;
      y = x;
      context.strokeStyle = '#000000';
      context.stroke();
      context.moveTo(x, 0);
      context.lineTo(x, height);
      context.moveTo(0, y);
      context.lineTo(width, y);
    }
  }

  void draw() {
    //_clear();
    _border();
    _lines();
  }
  
  void _robotturn(int a){
    
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      for (var t =0; t < 3 ; t++){
        if(tabtest_j.contains(triosgagnants[i][t])){
          m++;
          if (m == 3){
            print("Partie terminée et mj=$m");
            m = 0;
          }    
        }
      } 
    }
    if(a==0){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 0, 0, 118, 118);
    }
    if(a==1){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 0, 120, 118, 118);
    }
    if(a==2){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 0, 240, 118, 118);
    }
    if(a==3){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 120, 0, 118, 118);
    }
    if(a==4){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 120, 120, 118, 118);
    }
    if(a==5){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 120, 240, 118, 118);
    }
    if(a==6){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 240, 0, 118, 118);
    }
    if(a==7){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 240, 120, 118, 118);
    }
    if(a==8){
      ImageElement img_rond =   
          document.query('#img_rond');
      context.drawImage(img_rond, 240, 240, 118, 118);
    }
    if (casejouee.contains(a)){
    tabtest_o.add(a);
    check_ordi.add(a);
    casejouee.removeAt(casejouee.indexOf(a, 0));
    print("Check ordi $check_ordi");
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      for (var t =0; t < 3 ; t++){
        if(tabtest_o.contains(triosgagnants[i][t])){
          m++;
          if (m == 3){
            print("Partie terminée et mo=$m");
            m=0;
          }   
        }
      } 
    }
      if(casejouee.isEmpty){
        for (var i=0; i < triosgagnants.length ; i++){
          var m = 0;
          for (var t =0; t < 3 ; t++){
            if(tabtest_o.contains(triosgagnants[i][t])){
              m++;
              if (m == 3){
                print("Partie terminée et mo=$m");
                m=0;
              }   
            }
          } 
        }
        print("PARTIE TERMINÉE");
      }
    }
  }
   
  void _onMouseDown(MouseEvent e) { 
    int ligne;
    int colonne;
    if(e.offsetX.toInt() < 120){
      ligne = 0;
    }else if(e.offsetX.toInt() < 240){
      ligne = 1;
    }else {
      ligne = 2;
    }
    if(e.offsetY.toInt() < 120){
      colonne = 0;
    }else if(e.offsetY.toInt() < 240){
      colonne = 1;
    }else {
      colonne = 2;
    }
    if (ligne == 0 && colonne == 0 && casejouee.contains(0)){
    ImageElement img_croix =   
        document.query('#img_croix');
    context.drawImage(img_croix, 0, 0, 118, 118);
    test = 0;
    }
    if (ligne == 0 && colonne == 1 && casejouee.contains(1)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 0, 120, 118, 118);
      test = 1;
    }
    if (ligne == 0 && colonne == 2 && casejouee.contains(2)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 0, 240, 118, 118);
      test = 2;
    }
    if (ligne == 1 && colonne == 0 && casejouee.contains(3)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 0, 118, 118);
      test = 3;
    }
    if (ligne == 1 && colonne == 1 && casejouee.contains(4)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 120, 118, 118);
      test = 4;
    }
    if (ligne == 1 && colonne == 2 && casejouee.contains(5)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 240, 118, 118);
      test = 5;
    }
    if (ligne == 2 && colonne == 0 && casejouee.contains(6)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 0, 118, 118);
      test = 6;
    }
    if (ligne == 2 && colonne == 1 && casejouee.contains(7)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 120, 118, 118);
      test = 7;
    }
    if (ligne == 2 && colonne == 2 && casejouee.contains(8)){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 240, 118, 118);
      test = 8;
    }
      print (test);
    temp = casejouee.indexOf(test, 0);
    if (casejouee.contains(test)){
      tabtest_j.add(test);
      check_joueur.add(test);
      casejouee.removeAt(temp);
      print("check_joueur $check_joueur");
       if(casejouee.isEmpty){
         for (var i=0; i < triosgagnants.length ; i++){
           var m = 0;
           for (var t =0; t < 3 ; t++){
             if(tabtest_j.contains(triosgagnants[i][t])){
               m++;
               if (m == 3){
                 print("Partie terminée et mj=$m");
                 m = 0;
               }    
             }
             
           } 
         }
         print("PARTIE TERMINÉE");
        }
        else {
        var index = new Random().nextInt(casejouee.length);
        print(casejouee[index]);
        _robotturn(casejouee[index]);
        }
    }
    else{
      print("Jouer une aure case SVP");
      
    }
  }
  
}
