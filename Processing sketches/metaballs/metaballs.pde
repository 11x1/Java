class ball {
   PVector pos;
   float rad;
   PVector velocity;
   int vel_limit = 2;
   
   ball(float pos_x, float pos_y) {
     pos = new PVector(pos_x, pos_y);
     rad = random(random(10000, 30000));
     velocity = new PVector(random(-vel_limit, vel_limit), random(-vel_limit, vel_limit));
   }
}

ArrayList<ball> balls = new ArrayList<ball>();

void setup() {
   size(800, 600);
  frameRate(60);
   balls.add(new ball(random(0, width), random(0, height)));
   
}

void draw() {
   background(0);
   balls.get(balls.size() - 1).pos.x = mouseX;
   balls.get(balls.size() - 1).pos.y = mouseY;
   
   for (ball b: balls) {
     if (b.pos.x < 0 || b.pos.x > width) {
        b.velocity.x *= -1; 
      }
      
      if (b.pos.y < 0 || b.pos.y > height) {
       b.velocity.y *= -1; 
      }
      
      b.pos.x += b.velocity.x;
      b.pos.y += b.velocity.y;
   }
   
   loadPixels();
   for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
         // main loop
         int pixel_num = x + y * width;
         float col = 0;
         for (ball b: balls) {
           float distance = dist(x, y, b.pos.x, b.pos.y); 
           col += b.rad / distance / 5;
         }
         pixels[pixel_num] = color(col);
      }
   }

   updatePixels();
}

void mouseReleased() {
     balls.add(new ball(mouseX, mouseY));
 }
 
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e *= -1000;
  balls.get(balls.size() - 1).rad += e;
}

void keyReleased(KeyEvent e) {
  if (String.format("%c", key).indexOf("-") == 0 && balls.size() > 1) {
    println("Balls --");
    balls.remove(1);
  } else if (String.format("%c", key).indexOf("+") == 0) {
    println("Balls ++");
    balls.add(new ball(random(0, width), random(0, height)));
  }
}
