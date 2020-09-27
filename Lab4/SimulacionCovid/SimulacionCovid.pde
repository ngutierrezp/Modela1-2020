Individuos simuPeople;
/*
   ___         _    _   ___ _           _      _   _          
  / __|_____ _(_)__| | / __(_)_ __ _  _| |__ _| |_(_)___ _ _  
 | (__/ _ \ V / / _` | \__ \ | '  \ || | / _` |  _| / _ \ ' \ 
  \___\___/\_/|_\__,_| |___/_|_|_|_\_,_|_\__,_|\__|_\___/_||_|

  ##########################
  # Explicación:
  
  Se ha realizado el código respecto a la simulación de covid para
  Personas representadas como pelotitas:
  
   VERDE: Persona sana
   ROJO: Persona enferma
   AZUL: Persona recuperada
   
  Las personas recuperadas poseen inmunidad al contagio, por lo que
  no se puden volver a contagiar si interactuan con personas enfermas
  
  
  
  #### Contagios #### 
  * Los rectangulos blacos reempresentan mascarillas y se tiene
  las siguientes probabilidades respecto a los contagios:
  
  - Enfermo con mascarilla -> Sano con mascarilla = 25% por la probabilidad de contagio
  - Enfermo sin mascarilla -> Sano con mascarilla = 33% por la probabilidad de contagio
  - Enfermo con mascarilla -> Sano sin mascarilla = 50% por la probabilidad de contagio
  - Enfermo sin mascarilla -> Sano sin mascarilla = 100% por la probabilidad de contagio

  #########################
  # Constantes:
  #########################
*/

float pEnfermos = 0.05;                    // Probabilidad de enfermos
float pMaskOn = 0.8;                       // Probabilidad de mascarillas
float pTransmission = 0.05;                // Probabilidad de transmisición
int radius = 8;                            // Radio de las pelotitas
float vel = 1.0;                           // Multiplicativo de velocidad (ponderación)
float minDistance = 2*radius;              // Distancia minima de interacción
float socialDistancing = 1.5*minDistance;  // Distancia maxima de contagio
int maxTiempoEnfermo = 500;                // Tiempo maximo que dura el contagio
float pInHouse = 0.1;                      // Probabilidad de personas en Casa



/*
 Inicialización del código
*/

void setup() {
  size(1024,1024);
  simuPeople = new Individuos(300, pEnfermos, pInHouse, pMaskOn, pTransmission, socialDistancing);
}

/*
 Bucle de simulación
*/


void draw() {
  background(250);
  simuPeople.run();
}
