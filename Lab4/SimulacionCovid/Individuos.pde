/*
  ######################
  # CLASE INDIVIDUOS
  ######################
  
  La clase individuos representa a un arreglo de muchas personas
  que pueden estar enfermas, sanas y recuperadas.







*/

public class Individuos{
  
  ArrayList<Individuo> individuos;
  float probSick;
  float probMaskOn;
  float probHome;
  int entities;
  float socialDistance;
  float probTransmission;
  
  /*
    Constructor: 
    En el constructor de la clase se asegura que al momento de colocar a las personas, 
    estas no queden unas sobre otras.
  
  */
  Individuos(int sizePeople, float probSick, float pInHouse, float probMaskOn, float pTransmission, float socialDistance){
    this.probHome = pInHouse;
    this.probTransmission = pTransmission;
    this.socialDistance = socialDistance;  
    this.entities = sizePeople;
    this.probSick = probSick;
    this.probMaskOn = probMaskOn;
    this.individuos = new ArrayList<Individuo>();
    
    for (int i = 0; i < sizePeople; i++) {
      
      float randSick = random(0,1);
      float randMask = random(0,1);
      float randHome = random(0,1);
      boolean usesMask = (randMask <= probMaskOn) ? true: false;
      boolean inHome = (randHome <= probHome) ? true: false;
      
      PVector pos = new PVector(random(0,1024),random(0,1024));
      
      //Generate random position until it finds an empty space (non-collision)
      while(testInitialCollision(pos)){ 
        pos = new PVector(random(0,1024),random(0,1024));
      }
      
      if(randSick <= probSick){
        individuos.add(new Sick(pos.x, pos.y, usesMask, inHome));
      }
      else{
        individuos.add(new Healthy(pos.x, pos.y, usesMask, inHome));
      }
      
    }
    
  }
  
  void run(){
    actions();
    move();
  }
  
  void move(){
    for(Individuo i : individuos){
      if(i instanceof Healthy){
          ((Healthy) i).run();
      }else if(i instanceof Sick){
          ((Sick) i).run();
      }else if(i instanceof Recovered){
        ((Recovered) i).run();
      }
    }
  }
  /*
    ACTION: 
    
      Se verifica primeramente si una persona enferma
      se ha recuperado o no.
      
      Luego:
      Se intera por individuos preguntando si se 
      encuentra en casa o no. De estar en casa este
      este se ignora para la interacción con los demás
      individuos. Si no está en casa, este se verifica
      si existen personas cercanas para contagiar o ser
      contagiado dada la probabilidad anterior. 
  
  */
  void actions(){
    Individuo objA;
    Individuo objB;
    for(int i = 0; i < entities; i++){
      objA = individuos.get(i);
      
      if(objA.inHome){
        if(objA instanceof Sick){
          checkRecovery(i, objA);
        }
        continue;
      }
      
      if(objA instanceof Sick){
        checkRecovery(i, objA);
        infection(objA.maskOn, objA.position);
      }
      
      for(int j = i+1; j < entities; j++){
        objB = individuos.get(j);
        if(objB.inHome) continue;
        objA.checkCollision(objB);
      }
    }
  }
  
  
  /*
    CHECKRECOVERY: 
    
      Se pregunta si una persona se ha recuperado.
      En el caso de que se recupere, se hace un
      cambio de clase pasando de enfermo -> recuperado
                                  (Sick)    (Recovered)
  */
  
  
  
  void checkRecovery(int index, Individuo entity){
    int count = ((Sick) entity).recoverCount;
    if( count == maxTiempoEnfermo ){
      Recovered r = new Recovered((Sick) entity);
      individuos.set(index, r);
    }
  }
  
  
  /*
    TESTINITIALCOLLISION: 
    
      Se pregunta si exite un individuo en la posición
      dada, en caso de que exista un individuo en dicha
      posición, no se podria colocar otro individuo en esta.
  */
  boolean testInitialCollision(PVector pos){
    
    for(Individuo other : individuos){
      PVector distanceVect = PVector.sub(pos, other.position);
      // Calculate magnitude of the vector separating the balls
      float distanceVectMag = distanceVect.mag();
      if(distanceVectMag < minDistance){
        return true;
      }
    }
    return false;
  }
  
  
  
  /*
    GETSINFECTED: 
    
      Se establece las probabilidades de transmisión dado lo siguiente:
      
        - Enfermo con mascarilla -> Sano con mascarilla = 25% (1/4) por la probabilidad de contagio
        - Enfermo con mascarilla -> Sano sin mascarilla = 50% (1/2) por la probabilidad de contagio
        - Enfermo sin mascarilla -> Sano con mascarilla = 33% (1/3) por la probabilidad de contagio
        - Enfermo sin mascarilla -> Sano sin mascarilla = 100% (1)  por la probabilidad de contagio
        
        
     Y se verifica si se ha contagiado o no una persona.
  */
  boolean getsInfected(boolean healthyMaskOn, boolean sickMaskOn, float randTransmission){
    float pInfection;
    if(healthyMaskOn && sickMaskOn){
      pInfection = pTransmission/4;
    }else if(healthyMaskOn){
      pInfection = pTransmission/3;
    }else if(sickMaskOn){
      pInfection = pTransmission/2;
    }else{
      pInfection = pTransmission;
    }
    
    if(randTransmission < pInfection){
      return true;
    }
    return false;
  }
  
  /*
    INFECTION: 
    
      Se itera a los individuos preguntando si existe una interacción que involucre 
      contagio, de existir esta. Se hace un cambio de clase pasando de 
      una persona enferma -> sana
                  (Sick)   (Healthy)
  */
  void infection(boolean maskOn, PVector pos){
    
    for(int i = 0; i<entities; i++){
      Individuo other = individuos.get(i);
      if((other instanceof Healthy) && !other.inHome){
        PVector distanceVect = PVector.sub(pos, other.position);
        // Calculate magnitude of the vector separating the balls
        float distanceVectMag = distanceVect.mag();
        if(distanceVectMag < socialDistance){
          float randTransmission = random(0,1);
          if(getsInfected(maskOn, other.maskOn, randTransmission)){
            Sick s = new Sick((Healthy) other);
            individuos.set(i, s);
          }
        } 
      }
    }
  }

}
