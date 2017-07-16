import controlP5.*;

// Editable Values
int heroCount = 600;
int enemyCount = 600;
float heroSpawnY;
float enemySpawnY;

// Non-editable Values
ArrayList<Hero> heroes = new ArrayList<Hero>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();


int buttonWidth = 200;
int buttonHeight = 50;
int buttonVerticalOffset = 56;

int sliderWidth = 200;
int sliderHeight = 32;
int sliderVerticalOffset = 40;


Button pauseButton;
Button restartButton;
Slider heroSpawnRateSlider;
Slider enemySpawnRateSlider;
Slider2D heroSpawnPositionSlider2D;
Slider2D enemySpawnPositionSlider2D;

ControlP5 cp5;
boolean paused;

void setup()
{
  size(1600, 900);
  background(255);
  
  boolean paused = false;
  cp5 = new ControlP5(this);
  
  setupUI();
  
  createAllUnits();
}

void draw()
{
  if (!paused)
  {
    background(255);
    
    /*heroSpawnY = sin((millis() / 1000f));
    enemySpawnY = cos((millis() / 1000f));
    heroSpawnY = map(heroSpawnY, -1, 1, 0, height);
    enemySpawnY = height / 2f + random(-100, 100);*/
    
    int maxHeroRate = (int)heroSpawnRateSlider.getMax() + 1;
    int maxEnemyRate = (int)enemySpawnRateSlider.getMax() + 1;
    int heroSpawnRate = maxHeroRate - (int)heroSpawnRateSlider.getValue();
    int enemySpawnRate = maxEnemyRate - (int)enemySpawnRateSlider.getValue();
    
    float heroSpawnY = heroSpawnPositionSlider2D.getArrayValue()[1];
    float enemySpawnY = enemySpawnPositionSlider2D.getArrayValue()[1];
    float heroSpawnX = heroSpawnPositionSlider2D.getArrayValue()[0];
    float enemySpawnX = enemySpawnPositionSlider2D.getArrayValue()[0];
    
    /*if(frameCount % heroSpawnRate == 0) heroes.add(new Hero(new PVector(random(width - 100, width), heroSpawnY)));
    if(frameCount % enemySpawnRate == 0) enemies.add(new Enemy(new PVector(random(0, 100), enemySpawnY)));*/
    
    if(frameCount % heroSpawnRate == 0) heroes.add(new Hero(new PVector(heroSpawnX, heroSpawnY)));
    if(frameCount % enemySpawnRate == 0) enemies.add(new Enemy(new PVector(enemySpawnX, enemySpawnY)));
    
    for(int i = heroes.size() - 1; i >= 0; i--)
    {
      Hero h = heroes.get(i);
      
      h.updateTarget();
      h.updateSteering();
      h.spreadOut();
      h.updateMovement();
      h.display();
      
      if(h.isDead) heroes.remove(i);
    }
    
    for(int i = enemies.size() - 1; i >= 0; i--)
    {
      Enemy e = enemies.get(i);
      
      e.updateTarget();
      e.updateSteering();
      e.spreadOut();
      e.updateMovement();
      e.display();
      
      if(e.isDead) enemies.remove(i);
    }
    
    for(int i = bullets.size() - 1; i >= 0; i--)
    {
      Bullet b = bullets.get(i);
      
      b.update();
      b.display();
      
      if(b.isDead) bullets.remove(i);
    }
  }
}

public void createAllUnits()
{
  heroes.clear();
  enemies.clear();
  
  for(int i = 0; i < heroCount; i++)
    heroes.add(new Hero(new PVector(random(0, width), random(0, height))));  
  
  for(int i = 0; i < enemyCount; i++)
    enemies.add(new Enemy(new PVector(random(0, width), random(0, height))));  
}

//Slider2D createSlider2D(String name, int x, int y, int myWidth, int myHeight, 
//   float minX, float maxX, float minY, float maxY, float value)

public void setupUI()
{
  restartButton = createButton("RESTART", width - buttonWidth - 10, height - buttonHeight - 10, buttonWidth, buttonHeight);
  pauseButton = createButton("PAUSE", 10, height - buttonHeight - 10, buttonWidth, buttonHeight);
  heroSpawnRateSlider = createSlider("HERO_SPAWN_RATE", width - sliderWidth - 200, 10, sliderWidth, sliderHeight, 1, 10, 5);
  enemySpawnRateSlider = createSlider("ENEMY_SPAWN_RATE", 10, 10, sliderWidth, sliderHeight, 1, 10, 5);
  
  heroSpawnPositionSlider2D = createSlider2D("HERO_SPAWN_LOCATION", width - sliderWidth - 200, 10 + sliderVerticalOffset,
    int(sliderWidth * (23/12.0)), sliderHeight * 3, 0, width, 0, height, width /2, height / 2);
    
  enemySpawnPositionSlider2D = createSlider2D("ENEMY_SPAWN_LOCATION", 10, 10 + sliderVerticalOffset,
    int(sliderWidth * (23/12.0)), sliderHeight * 3, 0, width, 0, height, width /2, height / 2);
}

public void controlEvent(ControlEvent theEvent) 
{
  Controller object = theEvent.getController();
  
  if (object == pauseButton)
  {
    paused = !paused;
  }
  else if (object == restartButton)
  {
    createAllUnits();
  }
}

Button createButton(String name, int x, int y, int myWidth, int myHeight)
{
  Button button = cp5.addButton(name);
  button.setValue(0).setPosition(x, y).setSize(myWidth, myHeight);
  button.getCaptionLabel().setSize(myWidth / 10);
  return button;
}

Slider createSlider(String name, int x, int y, 
    int myWidth, int myHeight, float min, float max, float value)
{

  Slider slider = cp5.addSlider(name)
    .setCaptionLabel(name)
    .setPosition(x, y)
    .setColorCaptionLabel(color(0,0,0))
    .setSize(myWidth, myHeight)
    .setRange(min, max)
    .setValue(value)
    .setDecimalPrecision(2);
    
  slider.getCaptionLabel().setSize(20);
    
  return slider;
}

Slider2D createSlider2D(String name, int x, int y, int myWidth, int myHeight, 
    float minX, float maxX, float minY, float maxY, float valueX, float valueY)
{

  Slider2D slider = cp5.addSlider2D(name)
    .setCaptionLabel(name)
    .setPosition(x, y)
    .setColorCaptionLabel(color(0,0,0))
    .setSize(myWidth, myHeight)
    .setMinX(minX)
    .setMaxX(maxX)
    .setMinY(minY)
    .setMaxY(maxY)
    .setDecimalPrecision(2);
    //.setPosition(valueX, valueY);
    
  slider.getCaptionLabel().setSize(20);
    
  return slider;
}
