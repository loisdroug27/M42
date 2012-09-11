import com.shigeodayo.ardrone.processing.*;
import oscP5.*;
import netP5.*;

ARDroneForP5 ardrone;
OscP5 oscP5;

int speedX = 0;
int speedY = 0;
int speedZ = 0;
int speedSpin = 0;
int takeoff = 0;
int landing = 0;
int stop = 0;

/**
 *  added new method.
 *  void move3D(int speedX, int speedY, int speedZ, int speedSpin)
 *  @param speedX : the speed of x-axis, [-100,100]
 *  @param speedY : the speed of y-axis, [-100,100]
 *  @param speedZ : the speed of z-axis, [-100,100]
 *  @param speedSpin : the speed of rotation, [-100,100]
 */
void setup(){
  size(320, 240);
  
 ardrone=new ARDroneForP5("192.168.1.1");
  //connect to the AR.Drone.
 ardrone.connect();
  //connect to the sensor info.
 ardrone.connectNav();
  //connect to the image info.
 ardrone.connectVideo();
  //start the connections.
 ardrone.start();
  
  oscP5 = new OscP5(this,9999);
   
}

void draw(){
  background(204);  

  //get image from AR.Drone.
  PImage img=ardrone.getVideoImage(false);
  if(img==null)
    return;
  image(img, 0, 0);

  //print all sensor information.
  //ardrone.printARDroneInfo();
  //get each sensor information.
  float pitch=ardrone.getPitch();
  float roll=ardrone.getRoll();
  float yaw=ardrone.getYaw();
  float altitude=ardrone.getAltitude();
  float[] velocity=ardrone.getVelocity();
  int battery=ardrone.getBatteryPercentage();
  
  String attitude="pitch:"+pitch+"\nroll:"+roll+"\nyaw:"+yaw+"\naltitude:"+altitude;
  text(attitude, 20, 85);
  String vel="vx:"+velocity[0]+"\nvy:"+velocity[1];
  text(vel, 20, 140);
  String bat="battery:"+battery+" %";
  text(bat, 20, 170);
}

void oscEvent(OscMessage msg) {
  
         if (msg.checkAddrPattern("/ctlardrone") && msg.checkTypetag("iiii"))
         {                                                               
              speedX = msg.get(0).intValue();
              speedY = msg.get(1).intValue();
              speedZ = msg.get(2).intValue();
              speedSpin = msg.get(3).intValue(); 
                                                    }
                                                    
        else if (msg.checkAddrPattern("/takeoff") && msg.checkTypetag("i"))
        {           
              takeoff = msg.get(0).intValue();
                                                     }
                                                     
        else if (msg.checkAddrPattern("/landing") && msg.checkTypetag("i"))
        {           
              landing = msg.get(0).intValue();
                                                     }
                                                     
         else if (msg.checkAddrPattern("/stop") && msg.checkTypetag("i"))
        {           
              landing = msg.get(0).intValue();
                                                     }  

else if(keyCode==SHIFT){
      ardrone.takeOff(); } 
else if (keyCode==CONTROL)  { 
      ardrone.landing(); } 

else {
ardrone.move3D(speedX, speedY, speedZ, speedSpin);   }  
                                                     
                                                     
                                                     
      }                                               
 


