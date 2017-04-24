/*
By Jose Catarino, 2017

Processing interface model drone for faster and cheaper protyping with Arduino

Previous Version:
        N/A

Current Version:
        v0.0                  // 4/23/17, drone built. speed control ready
*/

// variables for adjustment using arrow keys
int arrowX = 1;
int arrowY = 50;

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


void setup() {
  size(1000, 1000);
}

void draw() {
  background(0);
  body();                              // draws frame of the body

  // set motor speeds
  speed1 = allSpeed;
  speed2 = allSpeed;
  speed3 = 4;
  speed4 = allSpeed;

  // write speeds to motors
  motor1(speed1);
  motor2(speed2);
  motor3(speed3);
  motor4(speed4);

  // spin
  c += .01;

  println(c);
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
      arrowY -= 2;
    } else if (keyCode == DOWN) {
      arrowY += 2;
    } else if (keyCode == RIGHT) {
      arrowX += 2;
    } else if (keyCode == LEFT) {
      arrowX -= 2;
    }
  }
}
