private void setCapaciteit (int cap) {
  if(cap < aantal) {
    throw new IllegalArgumentException();
  }
  if(cap != elementen.length) {
    Object[] nieuw = new Object[cap];
    Object temp;
    for(int i = 0; i < aantal; i++) {
      temp = elementen[i];
      nieuw[i] = temp;
    }
    elementen = nieuw;
  }
}
