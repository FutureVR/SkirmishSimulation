class Hero extends Fighter
{ 
  char symbol = 'h';
  
  Hero(PVector p)
  {
    super(p);  
  }
  
  void updateTarget()
  {
    smallestDistance = 2000;
    
    for(int i = 0; i < enemies.size(); i++)
    {
      distanceToTarget = mag(myPosition.x - enemies.get(i).myPosition.x, myPosition.y - enemies.get(i).myPosition.y);
      if(distanceToTarget < smallestDistance)
      {
        smallestDistance = distanceToTarget;
        closestIndex = i;
      }
    }
    
    if(enemies.size() > 0) targetPosition = enemies.get(closestIndex).myPosition.copy();
  }
  
  void spreadOut()
  {
    for(int i = heroes.size() - 1; i >= 0; i--)
    {
      PVector distance = PVector.sub(myPosition, heroes.get(i).myPosition);
      if(distance.mag() < 20)
      {
        distance.normalize();
        distance.mult(.1);
        super.addForce(distance.mult(4));
      }    
    }  
  }
  
  void display()
  {
    fill(0, 0, 200);
    ellipse(myPosition.x, myPosition.y, characterDiameter, characterDiameter);
  }
}