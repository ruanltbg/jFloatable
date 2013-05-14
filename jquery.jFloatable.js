// Generated by CoffeeScript 1.6.2
(function() {
  $.isJfloatable = function(el) {
    return $(el).data("jFloatable") !== void 0;
  };

  $.Jfloatable = function(el, options) {
    var base;

    base = this;
    base.$el = $(el);
    base.el = el;
    return base.$el.data("jFloatable", base);
  };

  $.jFloatable.defaultOptiomns = {
    limit: 0
  };

  $.fn.jFloatable = function(options) {
    return this.each(function() {
      return new $.Jfloatable(this, options);
    });
  };

}).call(this);