import 'jquery-ujs';
import Turbolinks from 'turbolinks';
import feather from 'feather-icons';
Turbolinks.start();

$(document).on('turbolinks:load', function() {
  feather.replace();
});
