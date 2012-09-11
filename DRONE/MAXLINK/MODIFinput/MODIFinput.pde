import maxlink.*;

// set the background color from Max
// jkriss ~ 28 july 2004
// updated 21 april 2005 for Processing 0085

// Open "color picker.pat" in the MaxLink examples folder 
// to control the color.

MaxLink link = new MaxLink(this,"move");

// these must be public
public int x,y,z,s;

void setup() {
  size(250,250);
  link.declareInlet("x");
  link.declareInlet("y");
  link.declareInlet("z");
  link.declareInlet("s");
}

void draw() {
  println(x+ ", "+y+", "+z+", "+s);
}
