/*
  ######################
  # CLASE RECOVERED    #
  ######################
  
  Clase que representa a las personas recuperadas

*/

public class Recovered extends Individuo{

  color fillColor = #3232cd;
  
  // Constructor para crear un agente recuperado a partir de un agente enfermo (se ha recuperado)
  Recovered(Sick s){
    super(s.position, s.velocity, s.maskOn, s.inHome);
  }
  
  // Render dibuja el círculo para los agentes recuperados. Le agrega una mascarilla en caso de tenerla
  void render() {
    stroke(100);
    fill(fillColor);
    circle(position.x, position.y, 2*radio);
    // Para enfermos se pone un rojo
    
    if(maskOn){
      fill(#FFFFFF);
      rect(position.x - radio, position.y, 1.9*radio, radio/1.5);
      //arc(position.x, position.y, radio, radio, 0, PI);
      
    }
  }
  
  void run(){
     update();
     borders();
     render();
  }
}
