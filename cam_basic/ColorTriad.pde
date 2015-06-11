class ColorTriad extends ColorPair{
  protected color midColor;
  
  ColorTriad(color _lowColor, color _midColor, color _highColor){
    super(_lowColor, _highColor);    
    lowColor = _lowColor;
    midColor = _midColor;
    highColor = _highColor;
  }
  
  color second(){
    return midColor;
  }
  
  color third(){
    return highColor;
  }
}
