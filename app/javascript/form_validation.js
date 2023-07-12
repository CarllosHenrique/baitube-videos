$(document).ready(function() {
  $('.avatar-preview').click(function() {
    $('#avatar-input').click();
  });

  $('#avatar-input').on('change', function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();

    reader.onload = function(e) {
      $('#avatar-preview').css('background-image', 'url(' + e.target.result + ')');
      $('#avatar-preview i').hide();

      // Fazer a requisição AJAX para atualizar o avatar
      var form = new FormData();
      form.append('avatar', file);

      $.ajax({
        url: '<%= my_channel_update_path %>',
        method: 'PATCH',
        data: form,
        processData: false,
        contentType: false,
        success: function(response) {
          console.log('Avatar atualizado com sucesso!');
        },
        error: function(xhr, status, error) {
          console.error('Ocorreu um erro ao atualizar o avatar:', error);
        }
      });
    }

    reader.readAsDataURL(file);
  });
});
