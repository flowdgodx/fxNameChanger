

// Loading UI
window.addEventListener('message', function(event) {
  switch (event.data.action) {
    case 'openMenu':
      $(".main_card").fadeIn();
      break;

    case 'closeMenu':
      $(".main_card").fadeOut();
        cleanInput();

      break;
  }
});

$(document).ready(function() {
    document.onkeyup = function(data) {
        if (data.which == 27) {
            $(".main_card").fadeOut();
            $.post('https://fxNameChanger/action', JSON.stringify({
                action: 'close',
              }));
        }
    };
  });


$(document).on('click', '#closeMenu', function() {
    $.post('https://fxNameChanger/action', JSON.stringify({
        action: 'close',
      }));
    $(".main_card").fadeOut();
    cleanInput();
  });

$(document).on('click', '#changeName', function() {
    $.post('https://fxNameChanger/action', JSON.stringify({
        action: 'changeName',
        citizenID: $('#citizenID').val(),
        firstname: $('#firstName').val(),
        lastname: $('#lastName').val()
      }));
})

function cleanInput() {
  setTimeout(function() {
    $('#citizenID').val('');
    $('#firstName').val('');
    $('#lastName').val('');
  }, 300);
}