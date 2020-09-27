public class Recovered extends Individuo{

  color fillColor = #3232cd;
  
  Recovered(float posX,float posY, boolean maskOn, boolean inHome){
    super(posX,posY, maskOn, inHome);
  }
   
  void render() {
    stroke(100);
    fill(fillColor);
    circle(position.x, position.y, radio);
    // Para enfermos se pone un rojo
    
    if(maskOn){
      fill(#FFFFFF);
      rect(position.x - radio/2, position.y, radio, radio/2.5);
      //arc(position.x, position.y, radio, radio, 0, PI);
      
    }
  }
  
  void run(){
     update();
     borders();
     render();
  }
}
