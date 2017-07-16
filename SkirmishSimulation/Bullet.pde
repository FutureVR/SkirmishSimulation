class Bullet
{
  // Editable Values
  float bulletDiameter = 4;
  float bulletDamage = 6;
  
  // Non-Editable Values
  PVector myPosition;
  PVector myVelocity;
  boolean isDead = false;
  
  
  Bullet(PVector p, PVector v)
  {
    myPosition = p.copy();  
    myVelocity = v.copy();
  }
  
  void update()
  { 
    myPosition.add(myVelocity);
    
    for(int i = heroes.size() - 1; i >= 0; i--)
    {  
      float heroRadius = heroes.get(i).characterDiameter / 2;
      float heroX = heroes.get(i).myPosition.x;
      float heroY = heroes.get(i).myPosition.y;
      
      if(myPosition.x > heroX - heroRadius && myPosition.x < heroX + heroRadius &&
          myPosition.y > heroY - heroRadius && myPosition.y < heroY + heroRadius)
      {
        isDead = true;
        heroes.get(i).takeDamage(bulletDamage);
        break;
      }
    }
    
    if(!isDead) 
    {
      for(int i = enemies.size() - 1; i >= 0; i--)
      {  
        float enemyRadius = enemies.get(i).characterDiameter / 2;
        float enemyX = enemies.get(i).myPosition.x;
        float enemyY = enemies.get(i).myPosition.y;
        
        if(myPosition.x > enemyX - enemyRadius && myPosition.x < enemyX + enemyRadius &&
            myPosition.y > enemyY - enemyRadius && myPosition.y < enemyY + enemyRadius)
        {
          isDead = true;
          enemies.get(i).takeDamage(bulletDamage);
          break;
        }
      }    
    }
  }
  
  void display()
  {
    fill(255, 204, 0);
    ellipse(myPosition.x, myPosition.y, bulletDiameter, bulletDiameter);
  }
  
  boolean isDead()
  {
    if(isDead) return true;
    else return false;
  }
}