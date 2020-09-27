public class Individuos{
  
  ArrayList<Individuo> individuos;
  float probSick;
  float probMaskOn;
  float probHome;
  int entities;
  float socialDistance;
  float probTransmission;
  
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
  
  
  void checkRecovery(int index, Individuo entity){
    int count = ((Sick) entity).recoverCount;
    if( count == maxTiempoEnfermo ){
      Recovered r = new Recovered((Sick) entity);
      individuos.set(index, r);
    }
  }
  
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
  
  
  /*
  //Testing collision without change in velocity
  //https://forum.processing.org/one/topic/simple-collision-detection.html
  void checkCollision2(Individuo a, Individuo b){
    float dx = b.position.x - a.position.x;
    float dy = b.position.y - a.position.y;
    float d = sqrt(sq(dx)+sq(dy)); // distance between balls
    if (d < minDistance) {
      // The two balls are colliding.
      float mag1 = sqrt(sq(a.velocity.x)+sq(a.velocity.y));
      float mag2 = sqrt(sq(b.velocity.x)+sq(b.velocity.y));
      b.velocity.x = (mag1*dx/d); //*a.drag;
      b.velocity.y = (mag1*dy/d); //*a.drag;
      a.velocity.x = -(mag2*dx/d); //*b.drag;
      a.velocity.y = -(mag2*dy/d); //*b.drag;
      
    }
  }*/
   
  
}
