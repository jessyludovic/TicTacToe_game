// Canvas inspiré par Educ_memory_game_s02/Board de Dzenan Ridjanovic
// https://github.com/dzenanr/educ_memory_game/tags
// Affichage du score inspiré par http://www.onlywebpro.com/2012/03/03/html5-game-development-adding-health-or-score-to-your-game/
// Jeu entièrement codé et adapté par Jessy-Ludovic de Javascript : http://www.dreamincode.net/forums/topic/184706-tic-tac-toe/

class Jeu {
  // Le plateau de jeu est dessiné durant l'intervalle de temps "interval" en ms.
  static const int interval = 150;

  // Création et initialisation de la zone de dessin (plateau de jeu en 2D)
  CanvasElement canvas;
  CanvasElement canvas2;
  CanvasRenderingContext2D context;
  // initialisation des variables (proprétés) de contrôle
  
  num width;
  num height;
  var test;
  List casejouee = [0,1,2,3,4,5,6,7,8];
  var check_joueur = new List() ;
  var check_ordi = new List() ;
  var check = new List() ;
  var tabtest_o = new List() ;
  var tabtest_j = new List() ;
  List triosgagnants = [[0,1,2],[0,3,6],[0,4,8],[3,4,5],[1,4,7],[2,4,6],[6,7,8],[2,5,8]];
  var temp;
  var score_joueur = 0;
  var score_ordi = 0;
  var score_nul = 0;
  bool fin = false;
  bool turn_ordi = false;
  
  // Adopté de la classe case 
  Case cases;

  // Constructeur de la classe jeu
  Jeu(this.canvas, this.cases) {
    context = canvas.getContext('2d');
    width = 360;
    height = 360;
    
  // Gestion des actions du joueur humain
    document.query('#canvas').on.mouseDown.add(_onMouseDown);
    document.on.keyDown.add(onKeyDown);
 
  // Dessine le plateau chaque interval en ms.
    document.window.setInterval(draw, interval);
   
  }
  
  // LES FONCTIONS (METHODE DU JEU)
  
  // efface le rectangle créé par canvas
  void _clear() {
    context.clearRect(0, 0, width, height);
  }
  // dessine le cadre rectangulaire du plateau
  void _border() {
    context.rect(0, 0, width, height);
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur    = 5;
    context.shadowColor   = '#aea4f2';
    context.strokeStyle = '#ffffff';
    context.stroke();
  }
  //  dessine le cadre des cellules du rectangle
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
  //  dessine le plateau avec les methodes précédentes 
  void draw() {
    _border();
    _lines();
  }
  
  //  dessine le petit cadre des statistiques et affiche les résultats
  void afficher_score(){
    ImageElement vide =   
        document.query('#vide');
    context.drawImage(vide, 360, 0, 150, 90);
    context.strokeStyle = '#000000';
    context.stroke();
    context.font = 'bold 12pt Calibri';
    context.fillStyle = "#000000";
    context.fillText('Parties gagnées: ${score_joueur}', 370,15);
    context.font = 'bold 12pt Calibri';
    context.fillStyle = "#000000";
    context.fillText('Parties perdues: ${score_ordi}', 370,45);
    context.font = 'bold 12pt Calibri';
    context.fillStyle = "#000000";
    context.fillText('Parties nulles    : ${score_nul}', 370,75);
    
  }
  //  Gère le cas où le joueur humain gagne (affiche les résultats et met à jour les stats)
  void gagne(){
    //_clear();
    score_joueur++;
    afficher_score();
    ImageElement gagne =   
        document.query('#gagne');
    context.drawImage(gagne, 360, 120, 200, 200);
    context.strokeStyle = '#000000';
    context.stroke();
  }
//  Gère le cas où le joueur humain perd  (affiche les résultats et met à jour les stats)
  void perdu(){
    //_clear();
    score_ordi++;
    afficher_score();
    ImageElement perdu =   
        document.query('#perdu');
    context.drawImage(perdu, 360, 120, 200, 200);
    context.strokeStyle = '#000000';
    context.stroke();
  }
//  Gère le cas où il n'y a pas de vainqueur  (affiche les résultats et met à jour les stats)
  void matchnul(){
    //_clear();
    score_nul++;
    afficher_score();
    ImageElement matchnul =   
        document.query('#matchnul');
    context.drawImage(matchnul, 360, 120, 200, 200);
    context.strokeStyle = '#000000';
    context.stroke();
  }
// affiche une image vide (toute blanche)
  void reset_vide(){
    //_clear();
    ImageElement vide =   
        document.query('#vide');
    context.drawImage(vide, 0, 0, 360, 360);
    context.strokeStyle = '#000000';
    context.stroke();
    
  }
// affiche une image disant "Vous commencez"  
  void reset_avous(){
    //_clear();
    ImageElement avous =   
        document.query('#avous');
    context.drawImage(avous, 0, 0, 360, 360);
    context.strokeStyle = '#000000';
    context.stroke();
  }
// affiche une image disant "L'ordinateur commence"
  void reset_alordi(){
    //_clear();
    ImageElement alordi =   
        document.query('#alordi');
    context.drawImage(alordi, 0, 0, 360, 360);
    context.strokeStyle = '#000000';
    context.stroke();
  }
 
// Stratégies d'attaque et de défense (intelligence) de l'ordinateur
  void robotchoix(){
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      bool t0 = false;
      bool t1 = false;
      bool t2 = false;
      // Attaque
      for (var t=0; t < 3 ; t++){
        if(tabtest_o.contains(triosgagnants[i][t])){
          m++;
          if(t==0){
            t0 = true;
          }
          if(t==1){
            t1 = true;
          }
          if(t==2){
            t2 = true;
          }
          if (m==2 && t==1 && check.contains(triosgagnants[i][2])){
            m=0;
          }
          else if (m==2 && t==2 && check.contains(triosgagnants[i][0])){
            m=0;
          }
          else if (m==2 && t==1){
            var index3 = triosgagnants[i][2];
            new Timer(500, (j) => robotturn(index3));
            return;
          }
          else if (m==2 && t==2 && t1==true && t2==true){
            var index4 = triosgagnants[i][0];
            new Timer(600, (j) => robotturn(index4));
            return;
          }
          else if (m==2 && t==2 && t0==true && t2==true){
            var index5 = triosgagnants[i][1];
            new Timer(600, (j) => robotturn(index5));
            return;
          }   
        } 
      }
    }
    // Défense
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      bool t0 = false;
      bool t1 = false;
      bool t2 = false;
      for (var t=0; t < 3 ; t++){
        if(tabtest_j.contains(triosgagnants[i][t])){
          m++;
          if(t==0){
            t0 = true;
          }
          if(t==1){
            t1 = true;
          }
          if(t==2){
            t2 = true;
          }
          if (m==2 && t==1 && check.contains(triosgagnants[i][2])){
            m=0;
          }
          else if (m==2 && t==2 && check.contains(triosgagnants[i][0])){
            m=0;
          }
          else if (m==2 && t==1){
            var index3 = triosgagnants[i][2];
            new Timer(500, (j) => robotturn(index3));
            return;
          }
          else if (m==2 && t==2 && t1==true && t2==true){
            var index4 = triosgagnants[i][0];
            new Timer(600, (j) => robotturn(index4));
            return;
          }
          else if (m==2 && t==2 && t0==true && t2==true){
            var index5 = triosgagnants[i][1];
            new Timer(1200, (j) => robotturn(index5));
            return;
          }   
        } 
      }
    }
    var index2 = new Random().nextInt(casejouee.length);
    print(casejouee[index2]);
    new Timer(700, (t) => robotturn(casejouee[index2]));
  }
  // Actions de l'ordinateur (affichage des pions (O) et vérification du statut des variables de contrôle)
  void robotturn(int a){
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      for (var t =0; t < 3 ; t++){
        if(tabtest_j.contains(triosgagnants[i][t])){
          m++;
          if (m == 3){
            gagne();
            fin = true;
            turn_ordi = true;
            print("Partie terminée et mj=$m");
            m = 0;
            return;
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
    check.add(a);
    casejouee.removeAt(casejouee.indexOf(a, 0));
    print("Check ordi $check_ordi");
    for (var i=0; i < triosgagnants.length ; i++){
      var m = 0;
      for (var t =0; t < 3 ; t++){
        if(tabtest_o.contains(triosgagnants[i][t])){
          m++;
          if (m == 3){
            perdu();
            fin = true;
            turn_ordi = false;
            print("Partie terminée et mo=$m");
            m = 0;
            return;
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
                perdu();
                fin = true;
                turn_ordi = false;
                print("Partie terminée et mo=$m");
                m = 0;
                return;
              }   
            }
          } 
        }
        matchnul();
        fin = true;
        var alea = new Random().nextInt(2);
        if(alea == 0){
          turn_ordi = true;
        }
        else{
          turn_ordi = false;
        }
        print("PARTIE TERMINÉE");
      }
    }
  }
  // Actions lorsque le joueur clique sur une case (affichage des pions (O) et vérification du statut des variables de contrôle)
  void _onMouseDown(MouseEvent e) { 
    int ligne;
    int colonne;
    if(fin == true && turn_ordi == true ){
      return;
    }
    if(fin == true && turn_ordi == false ){
      return;
    }
    
    if(e.offsetX.toInt() < 120 && e.offsetY.toInt() < 360 ){
      ligne = 0;
    }else if(e.offsetX.toInt() < 240 && e.offsetY.toInt() < 360){
      ligne = 1;
    }else if(e.offsetX.toInt() < 360 && e.offsetY.toInt() < 360){
      ligne = 2;
    }
    if(e.offsetY.toInt() < 120 && e.offsetX.toInt() < 360){
      colonne = 0;
    }else if(e.offsetY.toInt() < 240 && e.offsetX.toInt() < 360){
      colonne = 1;
    }else if(e.offsetY.toInt() < 360 && e.offsetX.toInt() < 360){
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
      check.add(test);
      casejouee.removeAt(temp);
      print("check_joueur $check_joueur");
     if(casejouee.isEmpty){
       for (var i=0; i < triosgagnants.length ; i++){
         var m = 0;
         for (var t =0; t < 3 ; t++){
           if(tabtest_j.contains(triosgagnants[i][t])){
             m++;
             if (m == 3){
               gagne();
               fin = true;
               turn_ordi = true;
               print("Partie terminée et mj=$m");
               m = 0;
               return;
             }    
           }
           
         } 
       }
       matchnul();
       fin = true;
       var alea = new Random().nextInt(2);
       if(alea == 0){
          turn_ordi = true;
       }
       else{
         turn_ordi = false;
       }
       print("PARTIE TERMINÉE");
       return;
      }
      else {
        robotchoix();
      }
    }
    else{
      print("Jouer une aure case SVP");
    }
  }
  // reinitialise le plateau lorsque le joueur appuie sur "espace"
  void onKeyDown(event) {
    ImageElement vide =   
        document.query('#vide');
    context.drawImage(vide, 360, 120, 200, 200);
    context.strokeStyle = '#000000';
    context.stroke();
    if (event.keyCode == 32) {
      if(fin == true && turn_ordi == true ){
        casejouee = [0,1,2,3,4,5,6,7,8];
        check_joueur = new List() ;
        check_ordi = new List() ;
        check = new List() ;
        tabtest_o = new List() ;
        tabtest_j = new List() ;
        fin = false;
        test=20;
        turn_ordi = false;
        reset_alordi();
        var alea = new Random(4).nextInt(9);
        new Timer(900, (t) => robotturn(alea));
      }
      else if(fin == true && turn_ordi == false ){
       casejouee = [0,1,2,3,4,5,6,7,8];
       check_joueur = new List() ;
       check_ordi = new List() ;
       check = new List() ;
       tabtest_o = new List() ;
       tabtest_j = new List() ;
       test = 20;
       fin = false;
       turn_ordi = false;
       reset_avous();
      // reset_vide();
      }
      else{
        casejouee = [0,1,2,3,4,5,6,7,8];
        check_joueur = new List() ;
        check_ordi = new List() ;
        check = new List() ;
        tabtest_o = new List() ;
        tabtest_j = new List() ;
        test = 20;
        fin = false;
        turn_ordi = false;
        reset_vide();
      }
    }
  } 
}