private void voegToe (Object obj) {
  if(elementen.length == aantal) {
    this.setCapaciteit(aantal*2);
  }
  this.elementen[aantal] = obj;
  this.aantal++;
}
