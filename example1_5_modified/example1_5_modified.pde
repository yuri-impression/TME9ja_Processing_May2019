import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;
Arduino arduino;
Minim minim;
AudioPlayer song;
AudioSample beep;

float xpos, ypos;
float radius = 15.0;
float speedX = 4.0;
float speedY = 3.5;
int directionX = 1;
int directionY = -1;
float racket = 250;
float racket2 = 250;
int counter1 = 0;
int counter2 = 0;

void setup() {
  size(800, 600);
  smooth();
  frameRate(60);
  ellipseMode(RADIUS);
  textAlign(CENTER);
  PFont font = createFont("Futura", 240);
  textFont(font);

  arduino = new Arduino(this, Arduino.list()[2], 57600);
  minim = new Minim(this);

  song = minim.loadFile("Kalimba.mp3", 2048);
  song.play();
  beep = minim.loadSample("beep.mp3", 256);

  arduino.pinMode(4, Arduino.INPUT);
  arduino.pinMode(7, Arduino.INPUT);
  
  xpos = width/2;
  ypos = height/2;
}

void draw() {
  //Background
  fill(255, 150);
  rect(0, 0, width, height);

  //Counter
  stroke(1);
  fill(0);
  textSize(30);
  text("1P: "+counter1, 100, 500);
  text("2P: "+counter2, 700, 100);

  //fail
  stroke(140);
  strokeWeight(5);
  line(0, height/2, width, height/2);
  noFill();
  ellipse(width/2, height/2, 50, 50);
  noStroke();
  fill(140, 100);
  rect(0, height-50, width, 50);//1P
  rect(0, 0, width, 50);//2P

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
  fill(0, 0, 255);
  rect (racket, 540, 150, 10);
  //1P
  if (/*keyCode == RIGHT*/arduino.digitalRead(7)==Arduino.HIGH) {
    racket = racket + 20;
    if (racket>width-150)racket = width-150;
  }
  if (/*keyCode == LEFT*/arduino.digitalRead(4)==Arduino.HIGH) {
    racket = racket - 20;
    if (racket<0)racket = 0;
  }
  //2P
  fill(255, 0, 0);
  rect (racket2, 50, 150, 10);//drawing racket
  if (keyPressed) {
    if (keyCode == RIGHT /*arduino.digitalRead(2)==Arduino.HIGH*/) {
      racket2 = racket2 + 20;
      if (racket2>width-150)racket2 = width-150;
    }
    if (keyCode == LEFT /*arduino.digitalRead(3)==Arduino.HIGH*/) {
      racket2 = racket2 - 20;
      if (racket2<0)racket2 = 0;
    }
  }

  //Racket_bounce
  if ((racket-5 < xpos) && (racket+155 > xpos) && (ypos+radius > 550) && (ypos+radius < 555) ) {
    directionY = -directionY;
    //beep.trigger();
    counter1++;
  }
  if ((racket2-5 < xpos) && (racket2+155 > xpos) && (ypos-radius < 50) && (ypos-radius > 45)) {
    directionY = -directionY;
    //beep.trigger();
    counter2++;
  }

  //speedUp
  speedX+=0.001;
  speedY+=0.001;


  //GameOver
  if (ypos > 554) { //for 1P
    xpos = 99999;
    ypos = 99999;
    fill(20, 240, 0);
    rect(200, 200, 400, 200);
    fill(0);
    textSize(40);
    text("1P LOST!", width/2, height/2);
    textSize(25);
    text("PRESS MOUSE TO RESET", width/2, height/2+40);
    song.pause();
  }
  if (ypos < 43) { //for 2P
    xpos = -99999;
    ypos = -99999;
    fill(20, 240, 0);
    rect(200, 200, 400, 200);
    fill(0);
    textSize(40);
    text("2P LOST!", width/2, height/2);
    textSize(25);
    text("PRESS MOUSE TO RESET", width/2, height/2+40);
    song.pause();
  }
}

//Reset when mouse is pressed
void mousePressed() {
  background(255);
  xpos = random(200, 500);
  ypos = random(300, 400);
  speedX = 4.0;
  speedY = 3.5;
  racket = 250;
  racket2 = 250;
  counter1=0;
  counter2=0;
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
