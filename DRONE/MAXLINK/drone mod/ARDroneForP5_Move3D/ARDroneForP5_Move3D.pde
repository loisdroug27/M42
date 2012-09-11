import com.shigeodayo.ardrone.processing.*;

ARDroneForP5 ardrone;

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

//control the AR.Drone via keyboard input.
void keyPressed(){
  if(key==CODED){
    if(keyCode==UP){
      ardrone.move3D(10, 0, 0, 0);//en avant
    }else if(keyCode==DOWN){
      ardrone.move3D(-10, 0, 0, 0);//en arriere
    }else if(keyCode==LEFT){
      ardrone.move3D(0, 10, 0, 0);//gauche
    }else if(keyCode==RIGHT){
      ardrone.move3D(0, -10, 0, 0);//droite
    }else if(keyCode==SHIFT){
      ardrone.takeOff();//decollage
    }else if(keyCode==CONTROL){
      ardrone.landing();//atterrissage
    }
  }else{
    if(key=='p'){
      ardrone.stop();//stop
    }else if(key=='d'){
      ardrone.move3D(0, 0, 0, -40); //spin right(cw)
    }else if(key=='q'){
      ardrone.move3D(0, 0, 0, 40);//spin left(ccw)
    }else if(key=='z'){
      ardrone.move3D(0, 0, 20, 0);//up
    }else if(key=='s'){
      ardrone.move3D(0, 0, -50, 0);//down
    }else if(key=='a'){
      ardrone.move3D(10, 10, 0, 0);//diagonally forward left
    }else if(key=='c'){
      ardrone.move3D(-10, -10, 0, 0);//diagonally backward right
    }else if(key=='e'){
      ardrone.move3D(10, 10, -10, 0);//diagonally forward left up
    }else if(key=='w'){
      ardrone.move3D(-10, -10, 10, 0);//diagonally backward right down
    }else if(key=='k'){
      ardrone.move3D(10, 0, 0, -20);//turn right
    }else if(key=='l'){
      ardrone.move3D(10, 0, 0, 20);//turn left
    }
    else if(key=='1'){
      ardrone.setHorizontalCamera();
    }else if(key=='2'){
      ardrone.setHorizontalCameraWithVertical();//前カメラとお腹カメラ
    }else if(key=='3'){
      ardrone.setVerticalCamera();//お腹カメラ
    }else if(key=='4'){
      ardrone.setVerticalCameraWithHorizontal();//お腹カメラと前カメラ
    }else if(key=='5'){
      ardrone.toggleCamera();//次のカメラ
    }
  }
}
void keyReleased() {
  ardrone.stop();
}
