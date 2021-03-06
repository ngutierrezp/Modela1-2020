/*
  ######################
  # CLASE HEALTHY      #
  ######################
  
  Clase que representa a las personas sanas

*/

public class Healthy extends Individuo{

  // Color verde
  color fillColor = #32cd32;
  
  
  Healthy(float posX,float posY, boolean maskOn, boolean inHome){
    super(posX,posY, maskOn, inHome);
  }
  
  // Render dibuja el círculo para los agentes sanos. Le agrega una mascarilla en caso de tenerla
  void render() {
    stroke(100);
    fill(fillColor);
    circle(position.x, position.y, 2*radio);
    // Para enfermos se pone un rojo
    
    if(maskOn){
      //arc(position.x, position.y, radio, radio, PI, 0);
      fill(#FFFFFF);
      rect(position.x - radio, position.y, 1.9*radio, radio/1.5);
    }
  }
  
  void run(){
     update();
     borders();
     render();
  }

}
