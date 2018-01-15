import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Data
Minim minim;
AudioPlayer player;
PImage trash;
PImage garbageCan;
PImage tree;
PImage picture;
PImage notebook;
PImage suitcase;
PImage heart;
PFont font;
Random rand = new Random();

// Start Screen
float theta = 0;
boolean start = false;
boolean play = false;
int trashX = 280;
int trashY = 170;

// Options
boolean hasRolledOverA = false;
boolean hasRolledOverB = false;
boolean hasRolledOverC = false;
boolean relationships = false;
boolean work = false;
boolean school = false;
boolean choose = false;

// Gameplay
RainTrash rain = new RainTrash(10);

void setup() {
  size(800, 600);
  smooth();
  noStroke();
  minim = new Minim(this);
  player = minim.loadFile("Music.mp3");
  trash = loadImage("trash.png");
  trash.resize(250, 250);
  garbageCan = loadImage("garbage.png");
  garbageCan.resize(591, 620);
  tree = loadImage("tree.png");
  tree.resize(300, 300);
  picture = loadImage("mirror.png");
  picture.resize(200, 200);
  suitcase = loadImage("suitcase.png");
  suitcase.resize(35, 35);
  heart = loadImage("heart.png");
  heart.resize(35, 35);
  notebook = loadImage("notebook.png");
  notebook.resize(35, 35);
  font = loadFont("KinoMT-48.vlw");
}

void draw() {
  if (!start) {
    startScreen();
  } else {
    if (!choose) {
      options();
    } else {
      garbageCan.resize(150, 150);
      trash.resize(70, 70);
      if (relationships) {
        livingRoom();
        image(garbageCan, mouseX, 450);
      } else if (work) {
        outdoors();
      } else {
        wall();
        image(garbageCan, mouseX, 250);
      }
      rain.startRain();
      rain.rain(2);
    }
  }
}

void brickWall() {
  for (int i = 0; i < 800; i += 500) {
    for (int j = 0; j < 600; j += 100) {
      strokeWeight(1);
      stroke(255, 255, 255);
      fill(115, 48, 31);
      rect(i, j, 100, 50);
      noFill();
      fill(119, 62, 47);
      rect(i+100, j, 100, 50);
      noFill();
      fill(99, 23, 3);
      rect(i+300, j, 100, 50);
      noFill();
      fill(73, 39, 30);
      rect(i+200, j, 100, 50);
      noFill();
      fill(77, 41, 32);
      rect(i+400, j, 100, 50);
      noFill();
    }
  }
  for (int i = -50; i < 800; i += 500) {
    for (int j = 50; j < 600; j += 100) {
      fill(99, 23, 3);
      rect(i, j, 100, 50);
      noFill();
      fill(119, 62, 47);
      rect(i+100, j, 100, 50);
      noFill();
      fill(77, 41, 32);
      rect(i+200, j, 100, 50);
      noFill();
      fill(115, 48, 31);
      rect(i+300, j, 100, 50);
      noFill();
      fill(73, 39, 30);
      rect(i+400, j, 100, 50);
      noFill();
    }
  }
}

void startScreen() {
  brickWall();
  image(garbageCan, 300, 300);
  textFont(font);
  textSize(100);
  fill(0);
  text("Hack Your Trash", 120, 120);
  fill(255);
  text("Hack Your Trash", 110, 110);
  noStroke();
  trash.resize(250, 250);
  if (dist(400, 300, mouseX, mouseY) < 100) {
    stroke(115, 255, 152);
    strokeWeight(6);
    if (mousePressed) {
      play = true;
      player.loop();
    }
  }
  fill(255);
  if (play == false) {
    pushMatrix();
    translate(400, 300);
    rotate(radians(theta));
    image(trash, -120, -130);
    popMatrix();
    fill(0);
    triangle(365, 250, 365, 350, 465, 300);
    theta += 0.5;
  } else {
    if (trashY <= 180) {
      image(trash, trashX, trashY);
      if (trashX >= 370) {
        trashY += 4;
      } else {
        trashY -= 4;
      }
      trashX += 2;
    } else {
      start = true;
    }
  }
}

void options() {
  brickWall();
  fill(255, 255, 255);
  printPrompt();
  selectOptions();
  printOptions();
}

private void printPrompt() {
  textSize(40);
  text("What are you stressed out about today?", 10, 100); 
}

private void printOptions() {
  if (!hasRolledOverA) {
    textSize(40);
    text("Relationships", 250, 250); 
  } else {
    textSize(70);
    text("Relationships", 250, 250);
  }
  if (!hasRolledOverB) {
    textSize(40);
    text("Work", 250, 350); 
  } else {
    textSize(70);
    text("Work", 250, 350);
  }
  if (!hasRolledOverC) {
    textSize(40);
    text("School", 250, 450); 
  } else {
    textSize(70);
    text("School", 250, 450);
  }
}

private void selectOptions() {
  if((mouseX >= 250 && mouseX <= 510) && (mouseY >= 220 && mouseY <= 255)){
      hasRolledOverA = true;
      if (mousePressed) {
        relationships = true;
        choose = true;
        rain.setY(450);
        rain.setIcon(1);
      }
  } else if((mouseX >= 250 && mouseX <= 350) && (mouseY >= 320 && mouseY < 350)){ 
      hasRolledOverB = true;
      if (mousePressed) {
        work = true;
        choose = true;
        rain.setY(250);
        rain.setIcon(2);
      }
  } else if((mouseX >= 250 && mouseX <= 380) && (mouseY >= 420 && mouseY <= 450)){
      hasRolledOverC = true;
      if (mousePressed) {
        school = true;
        choose = true;
        rain.setY(300);
        rain.setIcon(3);
      }
  } else {
    hasRolledOverA = false;
    hasRolledOverB = false;
    hasRolledOverC = false;
  }
}

void outdoors() {
  noStroke();
  background(118, 224, 212);
  fill(80, 153, 56);
  ellipse(-200, 650, 1700, 900);//grass
  ellipse(400, 500, 600, 500);
  ellipse(800, 650, 900, 900);
  noFill();
  
  fill(239, 216, 9);
  ellipse(700, 75, 90, 90);//sun 
  image(tree, 10, 50);
  image(garbageCan, mouseX, 300);
  image(tree, 500, 300);
  drawCloud(625,75);
}

private void drawCloud(int x, int y){
  noStroke();
  fill(255);
  ellipse(x - 53, y + 10, 55, 55);
  ellipse(x + 2, y + 30, 80, 65);
  ellipse(x - 23, y - 20, 65, 65);
  ellipse(x + 27, y - 20, 55, 55);
  ellipse(x + 52, y + 20, 55, 55);
}

void livingRoom() {
  background(91, 44, 3);
  
  fill(0, 0, 0);
  rect(0, 410, 800, 190);
  fill(255, 255, 204);
  rect(0, 405, 800, 5);

  fill(17, 216, 230);
  rect(500, 150, 10, 55);
  noFill();
  fill(230, 159, 17);
  rect(510, 150, 10, 55);
  noFill();
  fill(17, 216, 230);
  rect(520, 150, 10, 55);
  noFill();
  fill(230, 159, 17);
  rect(540, 150, 10, 55);
  noFill();

  fill(233, 212, 168);
  rect(480, 205, 130, 10);
  noFill();

  fill(51, 51, 0);
  ellipse(585, 150, 10, 60);
  fill(51, 51, 0);
  ellipse(575, 170, 10, 40);

  fill(233, 168, 168);
  arc(580, 175, 40, 60, 0, PI, CHORD);

  fill(17, 216, 230);
  rect(500, 250, 10, 55);
  noFill();
  fill(230, 159, 17);
  rect(510, 250, 10, 55);
  noFill();
  fill(17, 216, 230);
  rect(530, 250, 10, 55);
  noFill();
  fill(230, 159, 17);
  rect(550, 250, 10, 55);
  noFill();

  fill(233, 212, 168);
  rect(440, 305, 130, 10);
  noFill();

  fill(51, 51, 0);
  ellipse(475, 250, 10, 60);
  fill(51, 51, 0);
  ellipse(465, 270, 10, 40);

  fill(233, 168, 168);
  arc(470, 275, 40, 60, 0, PI, CHORD);

  fill(255, 178, 102);
  quad(100, 300, 200, 300, 250, 400, 50, 400);
  fill(255, 153, 51);
  rect(50, 400, 200, 100);
  fill(255, 178, 102);
  quad(20, 350, 80, 350, 65, 500, 35, 500);
  quad(220, 350, 280, 350, 265, 500, 235, 500);
  rect(30, 495, 240, 5);
  line(86, 334, 215, 334);

  fill(255, 153, 153);
  quad(700, 200, 730, 200, 760, 250, 670, 250);
  fill(255, 153, 51);
  rect(707, 250, 10, 200);
   fill(255, 153, 153);
  ellipse(715, 445, 90, 10);
  
  image(picture, 150, 70);
}

void wall() {
  background(128);
  for (int i = 0; i < 800; i += 500) {
    for (int j = 0; j < 300; j += 100) {

      stroke(255, 255, 255);
      fill(115, 48, 31);
      rect(i, j, 100, 50);
      noFill();

      fill(119, 62, 47);
      rect(i+100, j, 100, 50);
      noFill();



      fill(99, 23, 3);
      rect(i+300, j, 100, 50);
      noFill();

      fill(73, 39, 30);
      rect(i+200, j, 100, 50);
      noFill();

      fill(77, 41, 32);
      rect(i+400, j, 100, 50);
      noFill();
    }
  }


  for (int i = -50; i < 800; i += 500) {
    for (int j = 50; j < 300; j += 100) {
      fill(99, 23, 3);
      rect(i, j, 100, 50);
      noFill();

      fill(119, 62, 47);
      rect(i+100, j, 100, 50);
      noFill();

      fill(77, 41, 32);
      rect(i+200, j, 100, 50);
      noFill();

      fill(115, 48, 31);
      rect(i+300, j, 100, 50);
      noFill();

      fill(73, 39, 30);
      rect(i+400, j, 100, 50);
      noFill();
    }
  }
}