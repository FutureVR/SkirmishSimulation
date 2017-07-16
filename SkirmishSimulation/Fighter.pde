class Fighter 
{
  //Editable Values
  public float characterDiameter = 10;
  float attackRadius = 100;
  float fighterDistance = 1.2;
  float maxBulletSpeed = 5;
  float shotDelay = 1000;
  float health = 10;
  float maxVelocity = 4;
  float maxForce = .5;
  
  // Non-editable Values
  PVector myPosition = new PVector();
  PVector myVelocity = new PVector(0, 0);
  PVector myAcceleration = new PVector();
  PVector targetPosition = new PVector(400, 400);
  float lastFireTime;
  boolean isDead = false;
  PVector desiredVelocity = new PVector();
  PVector steering = new PVector();
  float m = 10;
  float distanceToTarget;
  float smallestDistance = 1000;
  int closestIndex;
  
  
  Fighter(PVector p)
  {
    myPosition.x = p.x;
    myPosition.y = p.y;
  }
  
  void updateMovement()
  {
    myVelocity.add(myAcceleration);
    myPosition.add(myVelocity);
    myAcceleration = new PVector(0, 0);
  }
  
  void updateSteering()
  {
    desiredVelocity = PVector.sub(targetPosition, myPosition);
    
    if(desiredVelocity.mag() < attackRadius)
    {
      m = map(desiredVelocity.mag(), 0, attackRadius, 0, maxVelocity);
      m -= fighterDistance;
      desiredVelocity.setMag(m);
    }
    else
    {
      desiredVelocity.setMag(maxVelocity);
    }
    
    if(m >= 0 && m < .5)
    {
      shoot();  
    }
    
    steering = PVector.sub(desiredVelocity, myVelocity);
    steering.limit(maxForce);
    addForce(steering);
  }
  
  void shoot()
  {
    if(millis() - lastFireTime > shotDelay)
    {
      PVector bulletSpeed = PVector.sub(targetPosition, myPosition);
      PVector bulletPosition = myPosition;
      bulletSpeed.setMag(characterDiameter / 2);
      bulletPosition = PVector.add(myPosition, bulletSpeed);
      
      bulletSpeed.setMag(maxBulletSpeed);
      bullets.add(new Bullet(bulletPosition, bulletSpeed));
      lastFireTime = millis();
    }
  }
  
  void takeDamage(float damage)
  {
    health -= damage;
    if(health <= 0)
    {
      isDead = true;
    }
  }
  
  void addForce(PVector force)
  {
    myAcceleration.add(force);
  }
  
  boolean isDead()
  {
    if(isDead) return true;
    else return false;
  }
  
  void display()
  {
    ellipse(myPosition.x, myPosition.y, characterDiameter, characterDiameter);  
  }
}