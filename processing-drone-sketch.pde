/*
By Jose Catarino, 2017

Processing interface model drone for faster and cheaper protyping with Arduino

Previous Version:
        v0.0                  // 4/23/17, drone built. speed control ready
        v0.1                  // 4/24/17, identifies direction based on speed ration, but not yaw

Current Version:
        v0.2                  // 4/24/17, text input for real time speed adjustment
*/

// variables for adjustment using arrow keys
int arrowX = 0;
int arrowY = 0;

float c = 0;                               // rotation constant

// speed variables
int allSpeed = 8;
int speedForward = 1;
int speedBackward = 1;
int speedLeft = 1;
int speedRight = 1;
int speed1 = 1;
int speed2 = 1;
int speed3 = 1;
int speed4 = 1;

// rpm variables
int rpm1 = 1;
int rpm2 = 1;
int rpm3 = 1;
int rpm4 = 1;
int rpmFactor = 1000;

int opacity1 = 0;
int opacity2 = 0;
int opacity3 = 0;
int opacity4 = 0;

String direction = "up";
int setSpeed1;
int setSpeed2;
int setSpeed3;
int setSpeed4;


import controlP5.*;

ControlP5 cp5;

String textValue = "";

void setup() {
  size(1000, 1500);

  PFont font = createFont("arial",20);
  cp5 = new ControlP5(this);
  motorInput();
}

void draw() {
  background(0);
  body();                              // draws frame of the body

  setSpeed1 = int(cp5.get(Textfield.class,"motor1").getText());
  setSpeed2 = int(cp5.get(Textfield.class,"motor2").getText());
  setSpeed3 = int(cp5.get(Textfield.class,"motor3").getText());
  setSpeed4 = int(cp5.get(Textfield.class,"motor4").getText());


  // set motor speeds
  speed1 = setSpeed1;
  speed2 = setSpeed2;
  speed3 = setSpeed3;
  speed4 = setSpeed4;

  // write speeds to motors
  motor1(speed1);
  motor2(speed2);
  motor3(speed3);
  motor4(speed4);

  // spin
  c += .01;

  print(arrowY);
  print("    ");
  print(direction);
  print("    ");
  print(cp5.get(Textfield.class,"motor1").getText());
  print("    ");
  println(c);

  direction();
}

void body() {
  noStroke();
  fill(100);
  rect(420, 380, 160, 240);

  strokeWeight(20);
  stroke(100);
  line(430, 390, 270, 230);
  line(570, 390, 730, 230);
  line(430, 610, 270, 770);
  line(570, 610, 730, 770);

  noFill();
  strokeWeight(5);
  ellipse(270, 230, 300, 300);
  ellipse(730, 230, 300, 300);
  ellipse(270, 770, 300, 300);
  ellipse(730, 770, 300, 300);

  textSize(25);
  fill(255);
  text("Motor 1", 226, 46);
  text("Motor 2", 686, 46);
  text("Motor 3", 226, 586);
  text("Motor 4", 686, 586);

}

void motor1(int a) {
  // rotation matrix
  pushMatrix();                        // start matrix
  noStroke();
  fill(255);
  translate(270, 230);                 // move the origion point to (270, 230)
  rotate(c * a);                       // rotation based on speed factor
  rect(-10, -125, 20, 250);            // draw the blade
  popMatrix();                         // end matric

  // rpm value
  rpm1 = a * rpmFactor;                // speed * an rpm factor, default at 1000
  text("RPM: ", 200, 420);
  text(rpm1, 274, 420);                // print rpm value on screen
}

void motor2(int b) {
  // for annotation, see motor1()
  pushMatrix();
  noStroke();
  fill(255);
  translate(730, 230);
  rotate(-c * b);
  rect(-10, -125, 20, 250);
  popMatrix();

  rpm1 = b * rpmFactor;
  text("RPM: ", 660, 420);
  text(rpm1, 734, 420);
}

void motor3(int d) {
  // for annotation, see motor1()
  pushMatrix();
  noStroke();
  fill(255);
  translate(270, 770);
  rotate(-c * d);
  rect(-10, -125, 20, 250);
  popMatrix();

  rpm1 = d * rpmFactor;
  text("RPM: ", 200, 960);
  text(rpm1, 274, 960);
}

void motor4(int e) {
  // for annotation, see motor1()
  pushMatrix();
  noStroke();
  fill(255);
  translate(730, 770);
  rotate(c * e);
  rect(-10, -125, 20, 250);
  popMatrix();

  rpm1 = e * rpmFactor;
  text("RPM: ", 660, 960);
  text(rpm1, 734, 960);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      arrowY -= 1;
    } else if (keyCode == DOWN) {
      arrowY += 1;
    } else if (keyCode == RIGHT) {
      arrowX += 1;
    } else if (keyCode == LEFT) {
      arrowX -= 1;
    }
  }
}

void arrowUp(int f) {
  fill(85, 204, 0, map(f, 0, 10, 0, 255));
  rect(450, 120, 100, 100);
  triangle(400, 120, width/2, 50, 600, 120);
}

void arrowDown(int g) {
  fill(85, 204, 0, map(g, 0, 10, 0, 255));
  rect(450, 780, 100, 100);
  triangle(400, 880, width/2, 950, 600, 880);
}

void arrowLeft(int f) {
  fill(85, 204, 0, map(f, 0, 10, 0, 255));
  rect(120, 450, 100, 100);
  triangle(120, 400, 50, height/3, 120, 600);
}

void arrowRight(int f) {
  fill(85, 204, 0, map(f, 0, 10, 0, 255));
  rect(780, 450, 100, 100);
  triangle(880, 400, 950, height/3, 880, 600);
}

void direction() {
  if ((speed1 + speed2)/2 < (speed3 + speed4)/2 && speed1 == speed2 && speed3 == speed4) {
    direction = "forward";
    arrowUp(3);

  }
  if ((speed1 + speed2)/2 > (speed3 + speed4)/2 && speed1 == speed2 && speed3 == speed4) {
    direction = "backward";
    arrowDown(3);
  }
  if ((speed1 + speed3)/2 < (speed2 + speed4)/2 && speed1 == speed3 && speed2 == speed4) {
    direction = "left";
    arrowLeft(3);
  }
  if ((speed1 + speed3)/2 > (speed2 + speed4)/2 && speed1 == speed3 && speed2 == speed4) {
    direction = "right";
    arrowRight(3);
  }
  if (speed1 == speed2 && speed2 == speed3 && speed3 == speed4) {
    direction = "centered";
  }
  fill(255);
  text(direction, width/2, height/3);
}

void motorInput(){
    PFont font = createFont("arial",20);

  cp5.addTextfield("motor1")
     .setPosition(20,1200)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
  cp5.addTextfield("motor2")
     .setPosition(250,1200)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
        ;
   cp5.addTextfield("motor3")
     .setPosition(20,1400)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
   cp5.addTextfield("motor4")
     .setPosition(250,1400)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
}
