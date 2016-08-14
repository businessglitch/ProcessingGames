PFont font;
int radius = 20;
int ballxpos;
int ballypos;

int ballxspeed = 5;
int ballyspeed = 3;
int ballxdirection = 1;
int ballydirection = 1;

int rectWidth = 100;
int rectHeight = 10;
int rectxpos;
int rectypos;
int rectxspeed = 100;

int numofturns = 3;

//Colors

color red = color(255, 0, 0);
color orange = color(255, 135, 5);
color green = color( 40, 255, 26);
color yellow = color(250, 255, 3);



//Brick section
int BrickWidth = 100;
int BrickHeight =30;
int Brickxpos;
int Brickypos = 0;


int NumofBricks = 64;
int Maxrows = 8;
int Maxcolumns = 8;


int[] brick_X = new int [ NumofBricks ];
int[] brick_Y = new int [ NumofBricks ];
color[] brick_Color = new color [NumofBricks];  




color brickColor;


int points = 0;



void setup()

{
  background(0);
  size(800, 500);


  font = loadFont("Arial-Black-20.vlw");

  // Starting X and Y positions for ball
  ballxpos = width/2;
  ballypos = height/2;

  // Starting X and Y positions for paddle
  rectypos = height - rectHeight/2;
  rectxpos = width/2;



  ////// Assigns X and Y position and color for each brick
  ///// Assigns Color to brick according to rows
  for (int row = 0; row < Maxrows; row++) 
  {
    Brickxpos = 0;

    for (int column = 0; column < Maxcolumns; column++) {

      if (row <= 1)
        brickColor = red;
      else if (row > 1 && row <=3)
        brickColor = orange;
      else if (row > 3 && row <=5)
        brickColor = green;
      else 
        brickColor = yellow;


      brick_X[row*8 + column] = Brickxpos;
      brick_Y[row*8 + column] = Brickypos;
      brick_Color[row*8 + column] = brickColor;

      Brickxpos += BrickWidth;
    }

    Brickypos += BrickHeight;
  }
}


void draw()

{

  //// Calls brick and text Fucntion
  drawBricks();
  text1();



  /// Checks if the ball has hit a coloured brick
  //// If it does, Colors the brick black and bounces off
  for (int i = 0; i < NumofBricks; i++) 
  {
    if ((ballypos ) <= (radius + BrickHeight + brick_Y[i]) 
      && 
      ((ballxpos) >= (brick_X[i]) + (radius/2))
      && 
      (ballxpos) <= ((brick_X[i]) + (BrickWidth - radius/2))
      &&
      brick_Color[i] != color(0)) 


    {
      ballydirection *= -1;
      brick_Color[i] = color(0);
    }
  }






  ////////UPDATES BALLXPOS AND YPOS/////////////////////////////////
  ballxpos = ballxpos + ( ballxspeed*ballxdirection);
  ballypos = ballypos + ( ballyspeed*ballydirection);
  /////////////////////////////////////////////////////////////////


  // Restrictions for ball going out of window boundry
  /// and bouncing off
  if ( ballxpos < 0+radius/2 || ballxpos > (width -radius/2))
  {
    ballxdirection *= -1;
  }

  if ( ballypos < 0 +radius/2)
  {

    ballydirection *= -1;
  }
  /////////////////////////////////////////////////////////////////


  ///// Restrictions for ball hitting the Paddle////////////////////


  if ( ballypos >= (height - (rectHeight + radius/2)) && 
    ballxpos > (rectxpos - (rectWidth/2 +10)) &&
    ballxpos < (rectxpos + (rectWidth/2+10) ) )
  {
    ballydirection *= -1;
  }
  /////////////////////////////////////////////////////////////////



  //////Restrictions for the paddle staying in the window size////////////
  if ( rectxpos < rectWidth/2)

  {
    rectxpos = rectWidth/2;
  }

  if (rectxpos > width-rectWidth/2)
  {

    rectxpos = width-rectWidth/2;
  }
  /////////////////////////////////////////////////////////////////






  //////////// DRAWS THE BALL/////////////////////////////
  noStroke();
  fill(255);
  ellipse(ballxpos, ballypos, radius, radius);
  /////////////////////////////////////////////////////////////////




  /////////////// DRAWS THE  PADDLE///////////////////////////////
  fill(255, 0, 0);
  stroke(255);
  strokeWeight(2);
  rectMode(CENTER);
  rect(rectxpos, rectypos, rectWidth, rectHeight);

  /////////////////////////////////////////////////////////////////


  // Assigns points according to the brick color
  for (int k = 0; k < NumofBricks; k++) 
  {
    if ((ballypos ) <= (radius + BrickHeight + brick_Y[k]) 
      && 
      ((ballxpos) >= (brick_X[k]) + (radius/2))
      && 
      (ballxpos) <= ((brick_X[k]) + (BrickWidth - radius/2)))
    {

      if ( brick_Color[k] == yellow) 

      {
        points = points + 1;
      } else if ( brick_Color[k] == green)
      {

        points = points + 3;
      } else if ( brick_Color[k] == orange)
      {
        ballxspeed =6;
        ballyspeed =4;
        points = points +5 ;
      } else if ( brick_Color[k] == red)
      {
        ballxspeed =8;
        ballyspeed =5;
        points = points +7 ;
      }
    }




    // Substract a turn if the ball passes the paddle
    if (ballypos > height - radius/2)
    {
      numofturns--;

      ballypos = height/2;
      ballxpos= width/2;
    }


    ////// If turns = 0 then Game over Message is displayed
    if ( numofturns == 0)
    {

      textAlign(CENTER);
      textSize(50);
      text("Game Over", width/2, height/2);

      ballxpos = ballxpos*0;
      ballypos = ballypos*0 +radius/2;
    }


    // Checks if the ball has reached the top part of window
    // It bounces off the ball and sets paddle width to half
    // Just for One time
    if ( ballypos < radius/2)

    {

      if (rectWidth == 100)
      {
        rectWidth = rectWidth/2;
      }
      ballypos *= -1;
    }
  }
}


////////////// Keys for movement of the Paddle///////////////////
void keyPressed()
{
  if ( key == 'a' || key == 'A')
  {
    rectxpos = rectxpos - rectxspeed;
  }

  if ( key == 'd' ||  key == 'D')
  {
    rectxpos = rectxpos + rectxspeed;
  }
}

///////////////////////////////////////////////////////////////////



// Draws all the bricks, checks if brick color is black,
// Have a black stroke
void drawBricks () 
{
  background(0);  
  stroke(255);
  strokeWeight(3.5);

  for (int j = 0; j < NumofBricks; j++) 
  {

    if (brick_Color[j] == color(0))
    { 
      strokeWeight(0);
      stroke(0);
    } else 
    {

      stroke(255);
    }      
    strokeWeight(3.5);
    fill(brick_Color[j]);  
    rectMode(CORNER);
    rect(brick_X[j], brick_Y[j], BrickWidth, BrickHeight);
  }
}

//// Draws the Number of turns text and Total points on screen
void text1()

{

  fill(255);
  textSize(25);
  textAlign(CORNER);
  text("Total Points =", 500, height -50);
  text(points, 700, height-50);

  text("Number of turns =", 50, height -50);
  text(numofturns, 285, height-50);
}

