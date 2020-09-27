/*
  ######################
  # CLASE SICK         #
  ######################
  
  Clase que representa a las personas enfermas

*/

public class Sick extends Individuo{

  color fillColor = #cb3234;
  
  // Contador para el tiempo que lleva siendo enfermo
  int recoverCount = 0;
  
  Sick(float posX,float posY, boolean maskOn, boolean inHome){
    super(posX,posY, maskOn, inHome);
  }
  
  // Constructor para crear un agente enfermo a partir de un agente sano (fue contagiado)
  Sick(Healthy h){
    super(h.position, h.velocity, h.maskOn, h.inHome);
  }
   
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
    recoverCount += 1;
    update();
    borders();
    render();
  }
}
