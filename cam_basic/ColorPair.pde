class ColorPair{
  protected color lowColor, highColor;
  
  ColorPair(color _lowColor, color _highColor){
    lowColor = _lowColor;
    highColor = _highColor;
  }
  
  color first(){
    return lowColor;
  }
  
  color second(){
    return highColor;
  }
}
