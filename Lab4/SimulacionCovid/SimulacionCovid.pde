Individuos simuPeople;
int ticks = 0; //Tiempo global
// int steps = 10; //Número de pasos que se dan antes de cambiar de dirección
float pEnfermos = 0.05;
float pMaskOn = 0.8;
float pTransmission = 0.05;
int radius = 8;
float vel = 1.0;
float minDistance = 2*radius;
float socialDistancing = 1.5*minDistance;
int maxTiempoEnfermo = 500;
float pInHouse = 0.1;

void setup() {
  size(1024,1024);
  simuPeople = new Individuos(300, pEnfermos, pInHouse, pMaskOn, pTransmission, socialDistancing);
}

void draw() {
  background(250);
  ticks = ticks + 1; //Aumenta el tick del tiempo global
  simuPeople.run();
}
