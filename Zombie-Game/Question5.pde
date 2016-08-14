
PFont font;
Survivor[] Survivors = new Survivor[5];
// Creating an array of names for the survivors
String[] SurvivorNames = { 
  "Jhon", "Sasha", "Ali", "Jennifer", "Dora"
};


// Creating a name for each color
color Healthycolor = color(46, 252, 68);
color Infectedcolor = color(250, 236, 81);
color Injuredcolor = color(255, 56, 26);



class Survivor
{
// assigning the colors in an array
  color[] Survivorcolors= { 
    Healthycolor, Infectedcolor, Injuredcolor
  };


  float SurvivorSize = 75;
  float Survivorxpos; 
  float Survivorypos;
  color Survivorcolor;
  
  
  final int survivorspeed = 3;
  float survivordirection = 0;
 
  boolean Healthy = false;
  boolean Infected = false;
  boolean Injured = false;
  int bullets;
  
  
  int r = (int)random(3);


  String SurvivorName;

// The constructor takes name,tempx,tempy,tempbullets as parameters
  Survivor(String name,float tempx,float tempy, int tempbullets)

  {
    
     //parameters are equiated to global variables
    SurvivorName = name;
    Survivorxpos = tempx;
    Survivorypos = tempy;
    bullets = tempbullets;
    
    // if r is 0 , indicate that person is healthy and assign healthy color
    
    if ( r == 0)
    {
       Healthy = true;
       
       
      Survivorcolor = Healthycolor;
    }
    // if r is 1 , indicate that person is infected and assign infected color
    else if( r == 1)
    {
      Infected = true;
      Survivorcolor = Infectedcolor;
    }
     // if r is 2 , indicate that person is Injured and assign injured color
    else if ( r == 2)
    {
      Injured = true;
      Survivorcolor = Injuredcolor;
      
    }
    
   
    
     
  }
  // a function that draws the survivor and the survivor name
  void display()

  {
    // draws the survivor
      fill(Survivorcolor);
      
      ellipse(Survivorxpos, Survivorypos, SurvivorSize, SurvivorSize);
      
      // Draw the name of the survivor
        fill(255);
        textAlign(CENTER,CENTER);
        //textFont(font,15);
      text(SurvivorName,Survivorxpos,Survivorypos);
    }
    
    
    void movement()
    
    
    {
      
      

  float nextX =Survivorxpos + int(survivorspeed * cos(survivordirection));
  float nextY = Survivorypos + int(survivorspeed* sin(survivordirection));
  
  if (dist(nextX, nextY, mouseX, mouseY) > 25)
  {
    Survivorxpos = nextX;
    Survivorypos = nextY;    
  }

  survivordirection = atan2(mouseY - Survivorypos, mouseX - Survivorxpos);

    
    }
    
  }




// an integer function to callculate the percentage of healthy survivors

int populationofsurvivors(Survivor[] s)
{
  float count = 0;
  int percentage;
 
 
 
  for( int i = 0; i < 5; i++)
  {
    
  if(s[i].Healthy == true)
   {
     count ++;
  }
  
  }
   percentage = (int)(count/ float(5)  * 100);
   println( "Percentage: " + percentage +"%");
   return percentage;

}








void setup()
{
  size(500, 500);
  background(0);
  frameRate(5);
 //  New array of survivors with 5 slots
 
 for (int i = 0; i < Survivors.length; i++)
  {
    
   
   Survivors[i] = new Survivor(SurvivorNames[i],(int)random(75,width-75),(int)random(75,width-75),(int)random(0,100));
   
    
  }
  
  
  font = loadFont("Arial-Black-25.vlw");


   // a for lopp to add obecjts in array
  // A for loop for assainging diplay function to each object in array
  
  
  
  // draws the Percentage and number of bullets text on screen
  textFont(font,20);
  textAlign(CENTER,CENTER);
  text( "Percentage: " + populationofsurvivors(Survivors) + "%",100,20);
  text( "TotalBullets: " + totalbullets(Survivors),100,40);
}


// Calculates the total number of bullets with the total healthy survivors

int totalbullets(Survivor[] j)
{
  int totalbullets = 0;
  
  
  for(int i =0; i < 5; i++)
  {
  if (j[i].Healthy == true)
   {
     totalbullets += j[i].bullets;
  }
  }
 
   
  println("TotalBullets: " + totalbullets);
   return totalbullets;

}


void draw()
{
  
  background(0);
  for (int i = 0; i < Survivors.length; i++)
  {
   //Survivors[i] = new Survivor(SurvivorNames[i],(int)random(75,width-75),(int)random(75,width-75),(int)random(0,100));
   Survivors[i].movement();
    Survivors[i].display();
   
  }
  
  
}
