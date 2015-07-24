define(['jquery'], function($){
  var cool = {
    awesome: "If you're having a bad day, catch a wave.",
  };

  $('#inspiration').text(cool.awesome);

  return cool;
})
