private void voegToe (int index, Object obj) {
  if(index < 0 || index > aantal) {
  	throw new IndexOutOfBoundsException();
  }
  if(elementen.length == aantal) {
    this.setCapaciteit(aantal*2);
  }
  Object temp;
  for(int i = aantal; i > index; i--) {
  	temp = elementen[i-1];
  	elementen[i] = temp;
  }
  this.elementen[index] = obj;
  this.aantal++;
}
