
LinkedList<String> namen = new LinkedList<String>();
namen.add("Samson");
namen.add("Gert");
namen.add("Octaaf");
namen.add(2,"Alberto");
String verw = namen.remove(1);
verw = namen.remove(2);
boolean wasin = namen.remove("Burgemeester");
wasin = namen.remove("Alberto");
