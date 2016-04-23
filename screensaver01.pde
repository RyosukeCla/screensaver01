Clock c;
PFont font;
void setup() {
  size(displayWidth, displayHeight, P2D);
  //noCursor();
  c = new Clock();
  font = createFont("AvenirNext-UltraLight", 240, true);
  textFont(font);
  smooth();
  frameRate(30);
}

void draw() {
  background(0, 10, 20);

  c.update();
}

void mouseMoved(){
  //exit();
}

void keyPressed(){
  exit();
}

class Clock {
  int y, mo, d, h, mi, s;
  int ms, preMi;
  float alpha;
  float fadeSpeed;
  Clock() {
    dateUpdate();
    ms = 0;
    preMi = mi;
    alpha = 0;
    fadeSpeed = 2;
  }

  private float calcMiddle(float a, float b) {
    return a + (b - a) / 2.0;
  }

  private void dateUpdate() {
    y = year();
    mo = month();
    d = day();
    h = hour();
    mi = minute();
    s = second();
  }
  
  private void timeToAlpha() {
    if (h > 6 && h < 18) {
      if (alpha < 255) {
        alpha++;
      }
    } else {
      if  (alpha > -255) {
        alpha--;
      }
    }
  }

  private float timeToRad0() {
    float i = s + mi * 60.0 + h * 3600.0;
    return radians(360.0*i/86400.0);
  }
  private float timeToRad1() {
    float i = s + mi * 60.0;
    return radians(360.0*i/3600.0);
  }
  private float timeToRad2() {
    ;
    return radians(360.0*s/60.0);
  }
  private void frameSecond() {
    ms++;
    if (mi != preMi) {
      ms = 0;
      preMi = mi;
    }
  }
  private void sun(float a) {
    if (a > 0) {
      for (int i = 0; i < 8; i++) {
        pushMatrix();
        rotate(2*PI*i/8.0);
        fill(240, 200, 140, a);
        triangle(-height/60.0, 0, 0, height/15.0, height/60.0, 0);
        fill(0, 0, 20);
        triangle(-height/80.0, 0, 0, height/20.0, height/80.0, 0);
        popMatrix();
      }
      fill(240, 200, 140, a);
      ellipse(0, 0, height/20.0, height/20.0);
      fill(0, 0, 20);
      ellipse(0, 0, height/25.0, height/25.0);
    }
  }
  private void moon(float a) {
    if (a > 0) {
      fill(140, 200, 240, a);
      ellipse(0, 0, height/15.0, height/15.0);
      fill(0, 0, 20);
      ellipse(-height/80.0, -height/150.0, height/20.0, height/20.0);
    }
  }
  private String toStr(int t) {
    if (t >= 10) return "" + t;
    else return "0" + t;
  }
  private void system() {
    dateUpdate();
    frameSecond();
    timeToAlpha();
  }
  public void update() {
    system();
    float po0 = calcMiddle(height/2.5, height/2.8)/2.0;
    float po1 = calcMiddle(height/3.5, height/4.0)/2.0;
    float po2 = calcMiddle(height/5.4, height/6.2)/2.0;
    translate(width/3.5, height/2.0);
    noStroke();
    fill(25, 120, 206, 200);
    ellipse(0, 0, height/2.5, height/2.5);
    fill(0, 0);
    stroke(0, 0, 20, 150);
    arc(0, 0, po0*2, po0*2, -PI/2.0, -PI/2.0+timeToRad0());
    fill(0, 0, 50);
    noStroke();
    ellipse(po0*cos(-PI/2.0+timeToRad0()), po0*sin(-PI/2.0+timeToRad0()), height/60.0, height/60.0);
    fill(0, 0, 20);
    ellipse(0, 0, height/2.8, height/2.8);

    noStroke();
    fill(25, 120, 206, 200);
    ellipse(0, 0, height/3.5, height/3.5);
    fill(0, 0);
    stroke(0, 0, 20, 150);
    arc(0, 0, po1*2, po1*2, -PI/2.0, -PI/2.0+timeToRad1());
    fill(0, 0, 50);
    noStroke();
    ellipse(po1*cos(-PI/2.0+timeToRad1()), po1*sin(-PI/2.0+timeToRad1()), height/70.0, height/70.0);
    fill(0, 0, 20);
    ellipse(0, 0, height/4.0, height/4.0);

    fill(25, 120, 206, 200);
    ellipse(0, 0, height/5.4, height/5.4);
    fill(0, 0);
    stroke(0, 0, 20, 150);
    arc(0, 0, po2*2, po2*2, -PI/2.0, -PI/2.0+timeToRad2());
    if (s == 0) {
      
    }
    stroke(0, 0, 20);
    line(-height/5.0, 0, height/5.0, 0);
    line(0, -height/5.0, 0, height/5.0);
    fill(0, 0, 50);
    noStroke();
    ellipse(po2*cos(-PI/2.0+timeToRad2()), po2*sin(-PI/2.0+timeToRad2()), height/90.0, height/90.0);
    fill(0, 0, 20);
    ellipse(0, 0, height/6.2, height/6.2);

    moon(-alpha);
    sun(alpha);
    
    resetMatrix();
    String strH = toStr(h);
    String strM = toStr(mi);
    String strS = toStr(s);
    String strY = toStr(y);
    String strMo = toStr(mo);
    String strD = toStr(d);

    translate(width/1.5,height/2.0);
    textSize(height/7.0);
    fill(25, 120, 206);
    stroke(25, 120, 206);
    line(0,-height/5.0,0,height/5.0);
    line(height/5.0,-height/5.0,height/5.0,height/5.0);
    textAlign(CENTER,TOP);
    text(strH, -height/10.0,0);
    text(strM,height/10.0,0);
    text(strS, height*3/10.0,0);

    text(strMo,height/10.0,-height/6.0);
    text(strD, height*3/10.0,-height/6.0);
    textAlign(RIGHT, TOP);
    text(strY,-height/52.0,-height/6.0);
  }
}