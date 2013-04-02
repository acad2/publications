private boolean verwijder (Object obj) {
  Object temp;
  for(int i = 0; i < aantal; i++) {
  	temp = elementen[i];
  	if(temp.equals(obj)) {
  		verwijder(i);
  		return true;
  	}
  }
  return false;
}
