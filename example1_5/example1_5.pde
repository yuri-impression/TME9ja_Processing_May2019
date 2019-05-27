import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;
Arduino arduino;
Minim minim;
AudioPlayer song;
AudioSample beep;

float xpos = 100.0;
float ypos = 100.0;
float radius = 15.0;
float speedX = 6.0;
float speedY = 4.5;
int directionX = 1;
int directionY = -1;
float racket = 250;
int counter = 0;

void setup() {
  size(500, 500);
  smooth();
  frameRate(60); //Set frameRate() high in the game
  ellipseMode(RADIUS);
  
  //Use a particular font
  textAlign(CENTER);
  PFont font = createFont("Futura", 240);
  textFont(font);

  //instantiation and loading of files
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  minim = new Minim(this);
  song = minim.loadFile("Kalimba.mp3", 2048);
  beep = minim.loadSample("beep.mp3", 256);
  song.play();


  //Use firmata library to define pinMode()
  arduino.pinMode(4, Arduino.INPUT);
  arduino.pinMode(7, Arduino.INPUT);
}

void draw() {
  //Background
  fill(255, 150);
  rect(0, 0, width, height);

  //Counter
  stroke(1);
  fill(0);
  textSize(20);
  text("Score:"+counter, 450, 40);

  //Sea
  noStroke();
  fill(0, 100, 255);
  rect(0, 460, width, 40);

  //Ball
  fill(100);
  ellipse(xpos, ypos, radius, radius);

  //Bounce
  xpos += speedX * directionX;
  if ((xpos > width-radius) || (xpos < radius)) {
    directionX = -directionX;
  }
  ypos += speedY * directionY;
  if ((ypos > height-radius) || (ypos < radius)) {
    directionY = -directionY;
  }

  //Racket
  rect (racket, 450, 100, 10);
  //if (keyPressed) {
  if (/*keyCode == RIGHT*/arduino.digitalRead(7)==Arduino.HIGH) {
    racket = racket + 20;
    if (racket>width-100)racket = width-100;
  }
  if (/*keyCode == LEFT*/arduino.digitalRead(4)==Arduino.HIGH) {
    racket = racket - 20;
    if (racket<0)racket = 0;
  }
  //}

  //Racket_bounce
  if ((racket < xpos) && (racket+100 > xpos) && (ypos < 450) && (ypos > 440) ) {
    directionY = -directionY;
    beep.trigger();
    counter++;
  }

  //speedUp
  speedX+=0.001;
  speedY+=0.001;


  //GameOver
  if (ypos > 460) {
    //set the ball out of field
    xpos = 99999;
    ypos = 99999;
    fill(240, 20, 0, 130);
    rect(100, 200, 300, 100);
    fill(0);
    textSize(40);
    text("GAME OVER", width/2, height/2+10);
    textSize(10);
    text("Press any key to reset", width/2, height/2+30);
    song.pause();
  }
}

//Reset when any key is pressed
void keyPressed() {
  background(255);
  xpos = random(100, 400);
  ypos = random(100, 300);
  speedX = 6.0;
  speedY = 4.5;
  counter=0;
  song.rewind();
  song.play();
  draw();
}

//Always stop Minim when you close
void stop() {
  beep.close();
  minim.stop();
  super.stop();
}
