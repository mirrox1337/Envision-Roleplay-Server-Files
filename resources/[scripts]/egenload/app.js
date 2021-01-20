/* Coded in 4 mins includes debugging*/

var ocmo01 = "https://res.cloudinary.com/olssongraphics/video/upload/v1576258512/music_qdwxvf.ogg";
var ocmo03 = "https://res.cloudinary.com/warengonzagastorage/video/upload/v1466771010/owlcity-mo-03.mp3";

$(document).ready(function() {
        var audioLibrary = document.createElement('audio');
            audioLibrary.setAttribute('src', ocmo01); /* Default Song */
            audioLibrary.addEventListener('ended', function() {
              this.currentTime = 0;
              $('.play').show();
              $('.pause').hide();
            }, false);
        
        /* Some Code Fixes */
        $('.pause').hide();
        $("#03").hide();
        $.get();

        /* For Playing Music */
        $('.play').click(function() {
            audioLibrary.play();
            $('.play').hide();
            $('.pause').show();
        });
        /* For Pause Music */
        $('.pause').click(function() {
            audioLibrary.pause();
            $('.play').show();
            $('.pause').hide();
        });
        /* For Repeating Music */
        $('.repeat').click(function() {
            audioLibrary.pause();
            audioLibrary.currentTime = 0;
            audioLibrary.play();
        });
  
        /* For Song Selection */
        
        $('.changeSong01').click(function() {
            audioLibrary.setAttribute('src', ocmo01);
            audioLibrary.play();
            $('.play').hide();
            $('.pause').show();
            $("#01").show();
            $("#03").hide();
        });
  
        $('.changeSong03').click(function() {
            audioLibrary.setAttribute('src', ocmo03);
            audioLibrary.play();
            $('.play').hide();
            $('.pause').show();
            $("#01").hide();
            $("#03").show();
        });
    });