
class Cellule {

  int ligne;
  int colonne;
  String color;

  Case cases;

  Cellule(this.cases, this.ligne, this.colonne);

}

class Cellules {

  List liste;

  Cellules() {
    liste = new List();
  }

  void add(Cellule cellule) {
    liste.add(cellule);
  }

  Iterator iterator() {
    return liste.iterator();
  }

}
