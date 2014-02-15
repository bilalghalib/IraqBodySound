
import arb.soundcipher.*;

SCScore score = new SCScore();
float[] r = new float[4];
ArrayList<bombTime> bombInstance = new ArrayList();
int counter=0;


void setup() {
    size(1200, 600);

  String lines[] = loadStrings("output_beats.csv");
  for (int i = 0; i < lines.length; i++) {
      int values[] = int(lines[i].split( ",")); //very short and ugly !
      bombInstance.add( new bombTime(values[0], values[1], values[2], values[3]) );
}

  noLoop();
  score.tempo(320);
  score.addCallbackListener(this);
  makeMusic();
}

void makeMusic() {
  score.empty();
  
for(int j=0; j<114; j++){
 int spot = bombInstance.get(j).time;
 int loudness = bombInstance.get(j).strength;
loudness = (int)map(loudness, 7, 64, 70, 127);
  //score.addNote(spot, 1, score.PIANO, 70, 117, 0.25, 0.8, 0);
  score.addNote(spot, 9, 0, score.ACOUSTIC_BASS_DRUM, loudness, 0.25, 0.8, 64);  
      score.addCallback(spot, 1);

  }
  
  for (int i=0; i<999; i++) {
    //score.addNote(i, 0, score.PIANO, 60, 127, 0.25, 0.8, 127);
    score.addNote(i, 9, 0, 42, random(40) + 70, 0.25, 0.8, 64);
      score.addCallback(i, 2);

//  score.addNote(bombInstance.get(114).time/8, 9, 0, score.LOW_CONGA, 111, 0.25, 0.8, 64);  

}
  score.addCallback(999, 0);
  score.writeMidiFile("/Users/useradmin/Documents/Processing/IraqBodySound/attackMusicNotes.mid");
  score.play();      

}

class bombTime {
  public int time;
  public int strength;

  bombTime(int t, int beats, int bpm, int s) {
    time = t;
    strength = s;
  }
}


void handleCallbacks(int callbackID) {
  switch (callbackID) {
    case 0:
    println("break0");
      //score.stop();
      break;
    case 1: //base drum
    println("base");
    counter++;

      int w = bombInstance.get(counter).strength;
      w = (int)map(w, 7, 64, 100, 300);

      r = new float[] {600, 300, w, w};
      redraw();
      break;
    case 2: //cymbol
    println("cymbol");
      break;
  }
  
}


void draw() {
  background(120);
  rectMode(CENTER);
fill(204, 102, 0);
  rect(r[0], r[1], r[2], r[3]);
  println(r[0], r[1], r[2], r[3]);
}

void stop() {
  score.stop();
}

