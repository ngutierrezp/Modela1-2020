/*
  ######################
  # CLASE INDIVIDUO    #
  ######################
  
  Clase que representa a todo agente (clase padre)

*/
public class Individuo{
  
  PVector position;
  PVector velocity;
  boolean maskOn;
  boolean inHome;
  int radio = radius;
  float vel_mag = vel;
  float m = radius*5;
  
  /*
    Constructor:
      
      Utilizado al inicializar el programa
  */
  Individuo(float posX, float posY, boolean mask, boolean inHome){
    this.position = new PVector(posX, posY);
    this.maskOn = mask;
    this.inHome = inHome;
    this.velocity = (this.inHome)? new PVector(0,0): PVector.random2D().mult(vel_mag);
  }
  
  
  /*
    Constructor:
      
      Utilizado al hacer cambios de clase (Healthy -> Sick -> Recovered)
  */
  Individuo(PVector pos, PVector vel, boolean mask, boolean inHome){
    this.position = pos;
    this.velocity = vel;
    this.maskOn = mask;
    this.inHome = inHome; 
  }
  
  /*
    WALK:
     
     Cambia la posición del agente en la dirección de la velocidad 
  */
  void walk(){
    position.add(velocity);
  }
  
  void update(){
    walk();
  }
  
  
  /*
    BORDERS:
      
      Quita los bordes del canvas, haciendo que los agentes aparezcan del lado opuesto
      del canvas al superar los limites de éste
  
  */
  void borders() {
    if (position.x < -radio) position.x = width+radio;
    if (position.y < -radio) position.y = height+radio;
    if (position.x > width+radio) position.x = -radio;
    if (position.y > height+radio) position.y = -radio;
  }
  
  
  /*
    CHECKCOLLISION:
      
      Verifica si un individuo "choca" con otro, es decir si se encuentran
      a una mínima distancia entre la posición de cada uno.
      En caso de dectectar la colisión, modifica la dirección y magnitud de 
      las velocidades de cada agente en base al instante antes del choque
      
      Nota: El algoritmo fue adaptado de https://processing.org/examples/circlecollision.html
      Este algoritmo originalmente presentaba algunos problemas al ajustar la velocidad luego de la colisión
      Se redujo el significativamente efecto de este problema, pero aún persiste ocasionalmente.
      El resto del algoritmo se mantuvo sin cambios.
  */
  void checkCollision(Individuo other) {
    // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.position, position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    if (distanceVectMag <= minDistance) {
      float distanceCorrection = 0.1*(minDistance-distanceVectMag)/2.0;
      //*** NOTA: La corrección fue multiplicada por 0.1 para reducir el efecto del problema de colisión ***
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
