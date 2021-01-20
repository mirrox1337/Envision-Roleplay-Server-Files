<script>
// Get the video
var video = document.getElementById("myVideo");

// Get the button
var btn = document.getElementById("myBtn");

function aud_play_pause() {
  var myAudio = document.getElementById("Audio");
  if (myAudio.paused) {
    myAudio.play(k);
  } else {
    myAudio.pause(k);
  }
}

  function setup() {
    const cnv = createCanvas(600, 600);
  
    cnv.mouseClicked(() => {
      if (sound && sound.isPlaying()) {
        sound.pause();
      } else if (sound && !sound.isPlaying()) {
        sound.play();
      }
    });
  
    fft = new p5.FFT(0.75);
    colorMode(RGB);
    startColor = color(0, 0, 0);
    endColor = color(0, 0, 0);
  }
}
</script>