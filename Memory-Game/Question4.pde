


final int n = 4;
final int numberofTiles = 12;

// Array of how many tiles
int[] tiles = new int[numberofTiles];

//tile width and height
int tileWidth, tileHeight;


PImage picture;
PImage picture0, picture1, picture2, picture3, picture4, picture5;


int correct = 0;

boolean match = false;

void setup()
{
  String string;

  size(600, 600);

  tileWidth = width/(n-1);

  tileHeight = width/ n;

  initializingBoard(n);


  picture0 =loadImage("0.jpg");
  picture1 =loadImage("1.jpg");
  picture2 =loadImage("2.jpg");
  picture3 =loadImage("3.jpg");
  picture4 =loadImage("4.jpg");
  picture5 =loadImage("5.jpg");
}

void draw()
{
  //Checks if the detect is true but the other  tile is not matched as the first one, then closeTiles function is called

  if (detect == true)
  {
    if ( match == false)
    {
      closeTiles();
      detect=false;
    }
    detect = false;
  }
}


void Delay( int delay)
{
  // Time integer returns milliseconds function
  int time = millis();  
  while ( millis () < time + delay);
}

// Initalisez all the tiles on the screen in a 4x3 form.
void initializingBoard( int n)
{


  // Initales the tiles in Rows and columns
  fill(29, 65, 203);

  for (int row = 0; row < 3; row++)
  {
    for (int col = 0; col < 4; col++)
    {
      rect(row*tileWidth, col*tileHeight, width/(n-1), height/(n));
    }
  }



  // Assigns a value of -1 to each tile in the array
  for ( int i = 0; i< numberofTiles; i++)
  {

    tiles[i] = -1;
  }



  // since there are 6 pairs, for loop is passed to call the find random pair function.

  for (int pairNum = 0; pairNum < numberofTiles/2; pairNum++)

  {
    findRandomPair(pairNum);
    findRandomPair(pairNum);
  }
}

int rNum;

////////** This function finds pairs of tiles,
void findRandomPair (int j)
{
  int rNum = (int)random(numberofTiles);
  while (tiles[rNum] != -1)  //!= means not equal to 
  {
    rNum = (int)random(numberofTiles);
  }
  tiles[rNum] = j;
}
///////**




/// Opens the tiles according to the turns being even or odd, on mouse being pressed
int turn =0;
void mousePressed()
{
  //we need mouseX and mouseY
  if (turn %2== 0)
  {
    openTile1(); 
    turn++;
  } else {
    openTile2();
    turn++;
  }
}


//this info needed for closing and matching
int row1, col1, tileNum1;
int row2, col2, tileNum2;

// Checks for the each tile that if it is clicked
//Assigns the  image randomly in some random col and row
void openTile1()
{
  row1 = (int) (mouseX/ tileWidth);
  col1 = (int) (mouseY/ tileHeight);
  tileNum1 = col1*(n-1) + row1;



  switch(tiles[tileNum1]) {
  case 0: 
    picture=picture0;
    break;
  case 1: 
    picture=picture1;
    break;
  case 2: 
    picture=picture2;
    break;
  case 3: 
    picture=picture3;
    break;
  case 4: 
    picture=picture4;
    break;
  case 5: 
    picture=picture5;
    break;
  }

  image(picture, row1*tileWidth, col1*tileHeight, tileWidth, tileHeight);
}

//Assigns the same image randomly in some random col and row
void openTile2()
{
  row2 = (int)(mouseX/ tileWidth);
  col2 = (int)(mouseY/ tileHeight);
  tileNum2 = col2*(n-1) + row2;

  switch(tiles[tileNum2]) {
  case 0: 
    picture=picture0;
    break;
  case 1: 
    picture=picture1;
    break;
  case 2: 
    picture=picture2;
    break;
  case 3: 
    picture=picture3;
    break;
  case 4: 
    picture=picture4;
    break;
  case 5: 
    picture=picture5;
    break;
  }

  image(picture, row2*tileWidth, col2*tileHeight, tileWidth, tileHeight);
  matchPair();
}



int numTry = 0;
// this function checks for pairs
void matchPair()
{
  numTry++;


  // if my both tiles tend to be the same, increment my correct by 1
  if (tiles[tileNum1]== tiles[tileNum2])
  {
    correct++;

    // if my correct = my pair of tiles, display game message
    if (correct == (numberofTiles/2))
    {
      textSize(40);
      fill(255, 0, 0);
      text("Game Over", 100, 100);
      fill(255, 0, 0);
      text("Number of Tries" + numTry, 200, 300);



      turn=0;
      noLoop();
     
        initializingBoard(n);
        
        
      
      
    }
    match = true;
  } else
  {
    match = false;
    println("no match");

    detect=true;
  }
}



boolean detect=false;

//If my tiles are not the same, draws rectangles on them, to appear as if tiles are closing.
void closeTiles()
{
  Delay(500);
  rect(row1*tileWidth, col1*tileHeight, tileWidth, tileHeight); 
  rect(row2*tileWidth, col2*tileHeight, tileWidth, tileHeight);
}



