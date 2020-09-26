public class Sick extends Individuo{

  color fillColor = #cb3234;
  int recoverCount = 0;
  
  Sick(float posX,float posY, boolean maskOn){
    super(posX,posY, maskOn);
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
    recoverCount += 1;
    update();
    borders();
    render();
  }
}
