public class Healthy extends Individuo{

  color fillColor = #32cd32;
  
  Healthy(float posX,float posY, boolean maskOn, boolean inHome){
    super(posX,posY, maskOn, inHome);
  }
  
  
  void render() {
    stroke(100);
    fill(fillColor);
    circle(position.x, position.y, radio);
    // Para enfermos se pone un rojo
    
    if(maskOn){
      //arc(position.x, position.y, radio, radio, PI, 0);
      fill(#FFFFFF);
      rect(position.x - radio/2, position.y, radio, radio/2.5);
    }
  }
  
  void run(){
     update();
     borders();
     render();
  }

}
