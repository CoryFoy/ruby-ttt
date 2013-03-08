int incomingByte = 0;
int speakerPin = 3;
int sensorPin = 2;

int gamePin1 = 13;
int gamePin2 = 12;
int gamePin3 = 11;
int gamePin4 = 10;
int gamePin5 = 9;
int gamePin6 = 8;
int gamePin7 = 7;
int gamePin8 = 6;
int gamePin9 = 5;

int gamePins[9] = {gamePin1, gamePin2, gamePin3, gamePin4, gamePin5, gamePin6, gamePin7, gamePin8, gamePin9};

int INVALID_MOVE = 13;
int GAME_OVER = 99;
int MONITOR_FOR_PLAYER = 97;

int number_of_events = 0;

void setup() {
  pinMode(speakerPin, OUTPUT);
  for(int i = 0; i < 9; i++) {
   pinMode(gamePins[i], OUTPUT); 
  }
  Serial.begin(9600);
}

void handleIncomingPacket() {
 //protocol: 0 or 1 to turn on or off, followed by the game position - 1-9
 int on_or_off = Serial.read();
 Serial.println(on_or_off);
 if (on_or_off == INVALID_MOVE) {
   playNote('f', 500);
 } else if(on_or_off == GAME_OVER) {
   playNote('d', 200);
   playNote('b', 200);
   playNote('f', 400);
 } else if(on_or_off == MONITOR_FOR_PLAYER) {
   playNote('g', 60);
   monitor();
 } else {
   while(Serial.available() == 0) {
    delay(100); 
   }
   int pos = Serial.read();
   pos %= 16;
   int pin = gamePins[pos];
   digitalWrite(gamePins[pos], (on_or_off == 0 ? LOW : HIGH));
 }
}

void monitor() {
  number_of_events = 0;
  while(true) {
    int next = digitalRead(2);
    if(next == 1 && number_of_events == 0) {
      number_of_events = 1;
      playNote('a', 50);
      playNote('b', 50);
      playNote('c', 50);
      playNote('a', 50);
      Serial.println(next, DEC);
    } else if(next == 0) {
      number_of_events = 0;
    }
    
    delay(500);
  }
}

void loop() {
  if(Serial.available() > 0) {
    Serial.println("Incoming!");
    handleIncomingPacket();
  } 

}

void playTone(int tone, int duration) {
  for(long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = {'c', 'd', 'e', 'f', 'g', 'a', 'b', 'c'};
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
  for(int i = 0; i < 8; i++) {
   if(names[i] == note) {
    playTone(tones[i], duration);
   } 
  }
}
