class Enemy extends Fighter
{ 
  char symbol = 'e';
  
  Enemy(PVector p)
  {
    super(p);  
  }
  
  void updateTarget()
  {
    smallestDistance = 2000;
        
    for(int i = 0; i < heroes.size(); i++)
    {
      distanceToTarget = mag(myPosition.x - heroes.get(i).myPosition.x, myPosition.y - heroes.get(i).myPosition.y);
      if(distanceToTarget < smallestDistance)
      {
        smallestDistance = distanceToTarget;
        closestIndex = i;
      }
    }
    
    if(heroes.size() > 0) targetPosition = heroes.get(closestIndex).myPosition.copy();
  }
  
  void spreadOut()
  {
    for(int i = enemies.size() - 1; i >= 0; i--)
    {
      PVector distance = PVector.sub(myPosition, enemies.get(i).myPosition);
      if(distance.mag() < 20)
      {
        distance.normalize();
        distance.mult(.1);
        super.addForce(distance);
      }    
    }  
  }
  
  void display()
  {
    fill(200, 0, 0);
    ellipse(myPosition.x, myPosition.y, characterDiameter, characterDiameter);
  }
}