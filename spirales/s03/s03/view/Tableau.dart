// Inspiré par Educ_memory_game_s02/Board de Dzenan Ridjanovic
// https://github.com/dzenanr/educ_memory_game/tags
class Tableau {

  // The board is drawn every interval in ms.
  static const int interval = 8;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num width;
  num height;

  Case cases;

  Tableau(this.canvas, this.cases) {
    context = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;

    document.query('#canvas').on.mouseDown.add(onMouseDown);
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
  void onMouseDown(MouseEvent e) {
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
    if (ligne == 0 && colonne == 0){
    ImageElement img_croix =   
        document.query('#img_croix');
    context.drawImage(img_croix, 0, 0, 118, 118);
    }
    if (ligne == 0 && colonne == 1){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 0, 120, 118, 118);
    }
    if (ligne == 0 && colonne == 2){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 0, 240, 118, 118);
    }
    if (ligne == 1 && colonne == 0){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 0, 118, 118);
    }
    if (ligne == 1 && colonne == 1){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 120, 118, 118);
    }
    if (ligne == 1 && colonne == 2){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 120, 240, 118, 118);
    }
    if (ligne == 2 && colonne == 0){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 0, 118, 118);
    }
    if (ligne == 2 && colonne == 1){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 120, 118, 118);
    }
    if (ligne == 2 && colonne == 2){
      ImageElement img_croix =   
          document.query('#img_croix');
      context.drawImage(img_croix, 240, 240, 118, 118);
    }
  }
}
