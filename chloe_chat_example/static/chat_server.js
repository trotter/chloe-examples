socket = new io.Socket('awesome-town.local', { port: 8888 });

socket.on('connect', function () {
  $('#messages').append('<li><strong>You are connected!</strong></li>');
});

socket.on('message', function (data) {
  data = $.parseJSON(data);
  $('#messages').append('<li><strong>' + data.name + ':</strong> ' + data.message + '</li>');
});

socket.connect();

$('#chat-form').submit(function () {
  $message = $('#message');
  socket.send({name: $("#name").val(), message: $message.val()});
  $message.val('');
  return false;
});

