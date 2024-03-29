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
    context.shadowBlur    = 22;
    context.shadowColor   = '#000000';
    context.fillStyle = '#aea4f2';
    context.fill();
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
    _clear();
    _border();
    _lines();
  }

}
