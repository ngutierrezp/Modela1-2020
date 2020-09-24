Individuos simuPeople;
int ticks = 0; //Tiempo global
int steps = 10; //Número de pasos que se dan antes de cambiar de dirección
float pEnfermos = 0.5;
float pMaskOn = 0.5;

void setup() {
  size(1024,1024);
  int typeWalk = 1; //Tipo de movimiento: 1 si es coordenadas cartesianas o 2 con coordenadas polares
  simuPeople = new Individuos(300, pEnfermos, pMaskOn, typeWalk);
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
  boolean maskOn;
  float r;
  int radio = 10;
  float variance = 1;
  float mean = 0;
  int s = 2;
  float vectorX;
  float vectorY;
  
  
  // Creando el constructor:
  Individuo(float posX, float posY, int typeWalk, boolean mask){
    position = new PVector(posX, posY);
    this.typeWalk = typeWalk;
    maskOn = mask;
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


public class Healthy extends Individuo{

  color fillColor = #32cd32;
  
  Healthy(float posX,float posY,int typeWalk, boolean maskOn){
    
    super(posX,posY, typeWalk, maskOn);
    
  
  }
    void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    // Para sano se pone un color verde
    fill(fillColor);
    arc(position.x, position.y, radio, radio, PI, OPEN);
    fill(#FFFFFF);
  }
  
    void run(){
     update();
     borders();
     render();
     
  }

}



public class Sick extends Individuo{

  color fillColor = #cb3234;
  
  Sick(float posX,float posY, int typeWalk, boolean maskOn){
    super(posX,posY,typeWalk, maskOn);
  
  }
   
  void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    // Para enfermos se pone un rojo
    fill(fillColor); 
  }
  
  void run(){
     update();
     borders();
     render();
  }
}


public class Recovered extends Individuo{

  color fillColor = #3232cd;
  
  Recovered(float posX,float posY, int typeWalk, boolean maskOn){
    super(posX,posY,typeWalk, maskOn);
  }
   
  void render() {
    stroke(100);
    circle(position.x, position.y, radio);
    // Para enfermos se pone un rojo
    fill(fillColor); 
  }
  
  void run(){
     update();
     borders();
     render();
  }
}
  





public class Individuos{
  
  ArrayList<Sick> PeopleSick;
  ArrayList<Healthy> PeopleHealthy;
  float ProbSick;
  float ProbMaskOn;
  
  Individuos(int sizePeople, float probSick, float probMaskOn, int typeWalk){
  
    ProbSick = probSick;
    ProbMaskOn = probMaskOn;
    PeopleSick = new ArrayList<Sick>();
    PeopleHealthy = new ArrayList<Healthy>();
    
    for (int i = 0; i < sizePeople; i++) {
      
      float posX = random(0,1024);
      float posY = random(0,1024);
      
      float randSick = random(0,1);
      float randMask = random(0,1);
      
      boolean usesMask = (randMask <= ProbMaskOn) ? true: false;
      
      if(randSick <= ProbSick){
        PeopleSick.add(new Sick(posX, posY, typeWalk, usesMask));
      }
      else{
        PeopleHealthy.add(new Healthy(posX, posY, typeWalk, usesMask));
      }
      
    }
    
  
  }
  
  void run(){
    for(Sick s : PeopleSick){
      s.run();
    }
    
    for(Healthy h : PeopleHealthy){
      h.run();
    }
  }
  
  
  
}
