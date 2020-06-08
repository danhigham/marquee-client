$(function() {
  $('#picker').farbtastic('#color');

  $("form#marquee-form").on('submit', function(e){
    console.log("Posting message...");
    
    $.ajax({
      type: "POST",
      url: e.currentTarget.action,
      contentType: "application/json",
      dataType: 'json',
      data: JSON.stringify({
        message: $("textarea#message").val(),
        color: $("input#color").val()
      }),
      success: function() {
        //display message back to user here
        $("textarea#message").val("");
        $("#success-alert").fadeIn();
        setTimeout(function() {
          $("#success-alert").fadeOut();
        }, 3000);
      }
    });

    return false;
  });

  videojs('my_video', {autoplay: true}).play();
});