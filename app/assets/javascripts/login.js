(function() {
  var fr;
  var image;
  var email;

  $(document).ready(function() {
    $('#login-form button[type=submit]').click(function(e) {
      e.preventDefault();
      var fileInput = document.getElementById('image_file');
      var file = fileInput.files[0];
      if (file) {
        fr = new FileReader();
        fr.onload = function () {
          image = fr.result;
          email = $('#email').val();

          if (image && email) {
            $.post('/public/users/login', {
              email: email,
              image: image
            });
          }
        };
        fr.readAsDataURL(file);
      }
    });

    $('#user-form button[type=submit]').click(function(e) {
      e.preventDefault();
      var fileInput = document.getElementById('user_image_file');
      var file = fileInput.files[0];
      if (file) {
        fr = new FileReader();
        fr.onload = function () {
          var form = document.getElementById('user-form');

          image = fr.result;
          email = $('#email').val();

          if (image) {
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'user[image]';
            input.value = image;
            form.appendChild(input);
          }

          form.submit();
        };
        fr.readAsDataURL(file);
      }
    });
  });

})();