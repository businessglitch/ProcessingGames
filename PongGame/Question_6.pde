
float rad = 20;        // radius of the ball
float xpos, ypos;    // Starting positions of ball    

float xspeed = 5;  // Speed of the ball
float yspeed = 3;  // Speed of the ball

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top or Bottom

int ypos1 = height/2; // Left Paddle y position
int ypos2 = height/2; // Right Paddle y position

int rectwidth = 20; // Paddtle Width
int rectheight = 150;  //Paddle Height

int rectx = 10;  //Paddle X position
boolean f = false;


int p1Score = 0;  //Player 1 score
int p2Score = 0;  //Player 2 score
PFont font;

void setup()
{

  size (1000, 800);
  smooth();

  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;

  font = loadFont("Arial-Black-48.vlw");
}



void draw()

{

  background(0);
// Continous update of ball position
  xpos = xpos + ( xspeed * -xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  //MiddleLine
  stroke(255);
  strokeWeight(2);
  line(width/2, 0, width/2, height);


  texts();  //displays player names and scores


//left pong
    fill(255, 0, 0);
  rect(rectx, ypos1, rectwidth, rectheight);

  //rightpong
  rect(width-rectwidth-rectx, ypos2, rectwidth, rectheight);

// Restricitons for Paddle Movemets

  if (ypos1 < 0)
  {
    ypos1 = 0;
  }


  if (ypos1 > height -rectheight)
  {
    ypos1 = height- rectheight;
  }


  if (ypos2 < 0)
  {
    ypos2 = 0;
  }


  if (ypos2 > height -rectheight)
  {
    ypos2 = height- rectheight;
  }
  
  fill(255);
  //ball
  ellipse(xpos, ypos, rad, rad);
  
// Restrictions for Ball collisions
  if  ( xpos <= rectx+rectwidth+rectwidth && ypos >= ypos1 && ypos <= ypos1 + rectheight )
  {
    xdirection *=-1;
  }

  if  ( xpos >= width -rectx-rectwidth-rectwidth && ypos >= ypos2 && ypos <= ypos2 + rectheight )
  {
    xdirection *=-1;
  }

  if ( xpos > width )

  {
    xpos= width/2;
    ypos =height/2;
    p1Score++;
  }

  if (xpos < 0)
  {
    xpos = width/2;
    ypos = height/2;
    p2Score++;
  }
  if ( ypos < rad || ypos > height-rad)
  {
    ydirection *= -1;
  }
}


// All the text
void texts()
{
  //Title
  textFont(font, 24);
  textAlign(CENTER);
  text("PONG!", width/2+20, 25);
  //Player 1
  textFont(font, 16);
  textAlign(LEFT);
  text("Player 1 = ", 10, 20);
  text(p1Score, 102, 20);

  //player2
  textAlign(RIGHT);
  text("Player 2 = ", width-30, 20);
  text(p2Score, width-20, 20);
}

// Movement of  Paddles
void keyPressed()
{
  switch (key)
  {

  case 'w':
    {
      f = !f;
      if ( f)
      {
        ypos1 = ypos1 -50;
      }
    }
    break;
  case's': 
    {
      ypos1 = ypos1 +50;
    }
    break;
  case 'o':
    {
      ypos2 = ypos2 -50;
    }
    break;

  case 'k':
    {
      ypos2 = ypos2 +50;
    }

    break;
  }
}

