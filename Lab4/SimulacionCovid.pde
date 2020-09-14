Individuos simuPeople;

void setup() {
  size(1024,1024);
  int typeWall = 0;
  simuPeople = new Individuos(300,typeWall);
}

void draw() {
  background(250);
  simuPeople.run();
}

public class Individuo{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  int radio = 10;
  float variance = 0.5;
  float mean = 0;
  float angle = random(0,TWO_PI);
  int s = 1;
  float vectorX;
  float vectorY;
  
  
  // Creando el constructor:
  Individuo(float posX, float posY, int typeWall){
    position = new PVector(posX, posY);
   
    // Para el caso de la aceleración esta, no existe por el momento
    // debido a que no existen fuerzas que actuen en los individuos.
    acceleration = new PVector(0, 0);
    
    
    
    // Diferentes formas de moverse:
    
    // Random Gausiano
    if(typeWall == 1){
      // Recordemolos que un distribución Normal es varianza*Z + media
      vectorX = variance * randomGaussian() + mean;
      vectorY = variance * randomGaussian() + mean;
    
    }
    // Alternativa 
    else{
      
      vectorX = s * cos(angle);
      vectorY = s * cos(angle);
    }
    
    //Dependiendo de la signación de velocidad que se haga, sera el movimiento que se tenga 
    velocity = new PVector(vectorX, vectorY);

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
  
}


public class healthy extends Individuo{

  
  healthy(float posX,float posY,int typeWall){
    
    super(posX,posY, typeWall);
    
  
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

  sicky(float posX,float posY, int typeWall){
    
    super(posX,posY,typeWall);
  
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
  
  Individuos(int sizePeople,int typeWall){
  
    PeopleSicky = new ArrayList<sicky>();
    PeopleHealthy = new ArrayList<healthy>();
    
    for (int i = 0; i < sizePeople; i++) {
      
      float posX = random(0,1024);
      float posY = random(0,1024);
      
      float randomNumber = random(0,1);
      
      if(randomNumber <= ProbSick){
        PeopleSicky.add(new sicky(posX,posY,typeWall));
      }
      else{
        PeopleHealthy.add(new healthy(posX,posY,typeWall));
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
