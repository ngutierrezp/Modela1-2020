Individuos simuPeople;

void setup() {
  size(1024,1024);
  simuPeople = new Individuos(300);
}

void draw() {
  background(250);
  simuPeople.run();
}

public class Individuo{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float ProbSick = 0.1;
  float r;
  int radio = 10;
  boolean sick;
  
  
  // Creando el constructor:
  Individuo(float posX, float posY){
    position = new PVector(posX, posY);
    
    // El vector de velocidad para este caso es cte.
    // pero se define su valor inicial el cual no cambiará
    velocity = PVector.random2D();
    
    // Para el caso de la aceleración esta, no existe por el momento
    // debido a que no existen fuerzas que actuen en los individuos.
    acceleration = new PVector(0, 0);
    
    sick = false;
    // Para definir si un paciente esta enfermo o no, se emplea una variable r.    
    r = random(0,1);
    
    if (r <= ProbSick){
      sick = true;
    } 
  }
  
  
  void run(){
    update();
    borders();
    render();
  }
  
  
  void update(){
    position.add(velocity);
  }
  
  
  void borders() {
    if (position.x < -radio) position.x = width+radio;
    if (position.y < -radio) position.y = height+radio;
    if (position.x > width+radio) position.x = -radio;
    if (position.y > height+radio) position.y = -radio;
  }
  
  void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    
    // Si esta enfermo se cambia el color a rojo
    if(sick){
      fill(203, 50,52);
    }
    else{
      fill(50, 205,50);
    }
    
  }
  
}




public class Individuos{
  
  ArrayList<Individuo> People;
  
  
  Individuos(int sizePeople){
  
    People = new ArrayList<Individuo>();
    
    for (int i = 0; i < sizePeople; i++) {
      float posX = random(0,1024);
      float posY = random(0,1024);
      People.add(new Individuo(posX, posY));
    }
    
  
  }
  
  void run(){
    for(Individuo i : People){
      i.run();
    }
  
  }
  
  
  
}
