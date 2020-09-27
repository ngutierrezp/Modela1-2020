public class Recovered extends Individuo{

  color fillColor = #3232cd;
  
  
  Recovered(Sick s){
    super(s.position, s.velocity, s.maskOn, s.inHome);
  }
   
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
