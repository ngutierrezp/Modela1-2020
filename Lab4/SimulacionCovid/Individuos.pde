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
      while(testCollision(pos)){
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
    processCollisions();
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
  
  void processCollisions(){
    Individuo objA;
    Individuo objB;
    for(int i = 0; i < entities; i++){
      objA = individuos.get(i);
      
      if(objA instanceof Sick){
        checkRecovery(objA);
        infection(objA.position);
      }
      
      for(int j = i+1; j < entities; j++){
        objB = individuos.get(j);
        if(objB.inHome) continue;
        objA.checkCollision(objB);
      }
    }
  }
  
  
  void checkRecovery(Individuo entity){
    int count = ((Sick) entity).recoverCount;
    if( count == maxTiempoEnfermo ){
      ((Sick) entity).fillColor = #3232cd;
      //Recovered r = new Recovered(obj.position.x, obj.position.y, obj.maskOn);
      //individuos.set(i, r);
    }
  }
  
  boolean testCollision(PVector pos){
    
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
  
  void infection(PVector pos){
    
    for(Individuo other : individuos){
      if((other instanceof Healthy) && !other.inHome){
        PVector distanceVect = PVector.sub(pos, other.position);
        // Calculate magnitude of the vector separating the balls
        float distanceVectMag = distanceVect.mag();
        if(distanceVectMag < socialDistance){
          float randTransmission = random(0,1);
          if(randTransmission <= pTransmission){
            ((Healthy)other).fillColor = #ebd834;
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

public class Individuo{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  int typeWalk;
  boolean maskOn;
  boolean inHome;
  float r;
  int radio = radius;
  float variance = 1;
  float mean = 0;
  int s = 2;
  float vectorX;
  float vectorY;
  float m;
  
  
  // Creando el constructor:
  Individuo(float posX, float posY, boolean mask, boolean inHome){
    position = new PVector(posX, posY);
    maskOn = mask;
    this.inHome = inHome;
    m = radius*0.1;
    // Para el caso de la aceleración esta, no existe por el momento
    // debido a que no existen fuerzas que actuen en los individuos.
    acceleration = new PVector(0, 0);
    velocity = (this.inHome)? new PVector(0,0): PVector.random2D();
  }
  
  
  void walk(){
    position.add(velocity);
  }
  
  void update(){
    walk();
  }
  
  
  void borders() {
    if (position.x < -radio) position.x = width+radio;
    if (position.y < -radio) position.y = height+radio;
    if (position.x > width+radio) position.x = -radio;
    if (position.y > height+radio) position.y = -radio;
  }
  
  void checkCollision(Individuo other) {
    // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.position, position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    if (distanceVectMag <= minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  } 
}
