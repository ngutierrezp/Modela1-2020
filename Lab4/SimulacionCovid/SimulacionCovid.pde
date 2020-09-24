Individuos simuPeople;
int ticks = 0; //Tiempo global
int steps = 10; //Número de pasos que se dan antes de cambiar de dirección

void setup() {
  size(1024,1024);
  int typeWalk = 1; //Tipo de movimiento: 1 si es coordenadas cartesianas o 2 con coordenadas polares
  simuPeople = new Individuos(300,typeWalk);
}

void draw() {
  background(250);
  ticks = ticks + 1; //Aumenta el tick del tiempo global
  simuPeople.run();
}

public class Individuo{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  int typeWalk;
  float r;
  int radio = 10;
  float variance = 1;
  float mean = 0;
  int s = 2;
  float vectorX;
  float vectorY;
  
  
  // Creando el constructor:
  Individuo(float posX, float posY, int typeWalk){
    position = new PVector(posX, posY);
    this.typeWalk = typeWalk;
    // Para el caso de la aceleración esta, no existe por el momento
    // debido a que no existen fuerzas que actuen en los individuos.
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    //Dependiendo de la signación de velocidad que se haga, sera el movimiento que se tenga 
    //velocity = new PVector(vectorX, vectorY);

  }
  
  
  void walk(){
    if(ticks % steps != 0){ // Cada steps pasos cambia su dirección
      return;
    }
    
    // Diferentes formas de moverse:
    
    // 1. Random Gausiano
    if(typeWalk == 1){
      // Recordemolos que un distribución Normal es varianza*Z + media
      this.vectorX = variance * randomGaussian() + mean;
      this.vectorY = variance * randomGaussian() + mean;
    
    }
    // 2. Alternativa 
    else{
      float angle = random(0,TWO_PI);
      this.vectorX = s * cos(angle);
      this.vectorY = s * sin(angle);
    }
  }
  
  void update(){
    walk();
    position.add(vectorX, vectorY);
  }
  
  
  void borders() {
    if (position.x < -radio) position.x = width+radio;
    if (position.y < -radio) position.y = height+radio;
    if (position.x > width+radio) position.x = -radio;
    if (position.y > height+radio) position.y = -radio;
  }
  
}


public class healthy extends Individuo{

  
  healthy(float posX,float posY,int typeWalk){
    
    super(posX,posY, typeWalk);
    
  
  }
    void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    // Para sano se pone un color verde
    fill(50, 205,50);
  }
  
    void run(){
     update();
     borders();
     render();
     
  }

}



public class sicky extends Individuo{

  sicky(float posX,float posY, int typeWalk){
    
    super(posX,posY,typeWalk);
  
  }
   
  void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    // Para enfermos se pone un rojo
    fill(203, 50,52); 
  }
  
  void run(){
     update();
     borders();
     render();
  }
}
  





public class Individuos{
  
  ArrayList<sicky> PeopleSicky;
  ArrayList<healthy> PeopleHealthy;
  float ProbSick = 0.1;
  
  Individuos(int sizePeople,int typeWalk){
  
    PeopleSicky = new ArrayList<sicky>();
    PeopleHealthy = new ArrayList<healthy>();
    
    for (int i = 0; i < sizePeople; i++) {
      
      float posX = random(0,1024);
      float posY = random(0,1024);
      
      float randomNumber = random(0,1);
      
      if(randomNumber <= ProbSick){
        PeopleSicky.add(new sicky(posX,posY,typeWalk));
      }
      else{
        PeopleHealthy.add(new healthy(posX,posY,typeWalk));
      }
    }
    
  
  }
  
  void run(){
    for(sicky s : PeopleSicky){
      s.run();
    }
    
    for(healthy h : PeopleHealthy){
      h.run();
    }
  }
  
  
  
}
