;(function ($) {

  var centerFrontbox = function () {
    var w = $(window);
    var el = $(".frontbox");
    el.css({
      'position':'absolute',
      'top':Math.abs(((w.height() - el.outerHeight()) / 2) + w.scrollTop()),
      'left':Math.abs(((w.width() - el.outerWidth()) / 2) + w.scrollLeft())
    });
  };

  $(document).ready(function($){
    centerFrontbox();
  });

}($));
