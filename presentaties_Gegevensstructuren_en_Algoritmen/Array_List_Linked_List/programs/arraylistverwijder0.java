private Object verwijder (int index) {
  if(index < 0 || index >= aantal) {
  	throw new IndexOutOfBoundsException();
  }
  Object outp = elementen[index];
  Object temp;
  for(int i = index; i < aantal-1; i++) {
  	temp = elementen[i+1];
  	elementen[i] = temp;
  }
  elementen[aantal-1] = null;
  this.aantal--;
  return outp;
}
