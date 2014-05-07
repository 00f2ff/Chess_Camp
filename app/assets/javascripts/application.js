// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery_nested_form
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

// Sticky footer js
// rest a little above the bottom of the screen (10 px)
// Thanks to Charles Smith for this -- http://foundation.zurb.com/forum/posts/629-sticky-footer
$(window).bind("load", function () {
  var footer = $("#footer");
  var pos = footer.position();
  var height = $(window).height();
  height = height - pos.top;
  height = height - footer.height();
  gap = 10;
  if (height > 0) {
      footer.css({
          'margin-top': (height - gap) + 'px'
      });
  }
});

// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3200).fadeOut();
   });
});


// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});