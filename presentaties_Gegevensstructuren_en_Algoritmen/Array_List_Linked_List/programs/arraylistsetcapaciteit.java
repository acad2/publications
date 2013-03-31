private void setCapaciteit (int capaciteit) {
	if(capaciteit < aantal) {
		throw new IllegalArgumentException();
	}
	if(capaciteit != elementen.length) {
		Object[] nieuw = new Object[capaciteit];
		for(int i = 0; i < aantal; i++) {
			nieuw[i] = elementen[i];
		}
		elementen = nieuw;
	}
}
