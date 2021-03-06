// Generated by CoffeeScript 1.6.2
(function() {
  $.isJfloatable = function(el) {
    return $(el).data("jFloatable") !== void 0;
  };

  $.Jfloatable = function(el, options) {
    var base, getInitialPosition, getLimit, getScrollTop, maxTop, originalData, reset, setAbsolute, setFix, setInitialPosition, target, targetTop, turnOff, turnOn, windowScroll;

    base = this;
    base.$el = $(el);
    base.el = el;
    base.$parentRelative = base.$el.parents(options.parentRelativeSelector).first();
    base.$el.data("jFloatable", base);
    target = base.$el;
    maxTop = null;
    originalData = {
      offset: null,
      style: null
    };
    base.isActive = true;
    getScrollTop = function() {
      if (window.pageYOffset !== void 0) {
        return window.pageYOffset;
      } else {
        return document.documentElement.scrollTop;
      }
    };
    targetTop = function() {
      return target.offset().top - parseFloat(target.css('marginTop').replace(/auto/, 0)) - base.options.top;
    };
    setFix = function() {
      var css, cssBase;

      cssBase = {
        position: 'fixed',
        top: base.options.top,
        left: originalData.offset.left
      };
      css = $.extend({}, cssBase, base.options.fixedCss);
      return target.css(css);
    };
    setAbsolute = function(limit) {
      var css, cssBase;

      cssBase = {
        position: 'absolute',
        top: (limit - base.$parentRelative.offset().top) + base.options.top
      };
      css = $.extend({}, cssBase, base.options.absoluteCss);
      return target.css(css);
    };
    getLimit = function() {
      if (base.options.limit > 0) {
        return base.options.limit - target.outerHeight() - base.options.top;
      } else {
        return $(document).outerHeight() - target.outerHeight() - base.options.top;
      }
    };
    windowScroll = function() {
      var limit, windowScrollTop;

      if (!base.isActive) {
        return false;
      }
      windowScrollTop = getScrollTop();
      limit = getLimit();
      if (windowScrollTop >= maxTop) {
        if (windowScrollTop < limit) {
          if (!target.hasClass("jFloatable-fixed")) {
            target.removeClass("jFloatable-absolute").addClass("jFloatable-fixed").removeAttr("style");
            return setFix();
          }
        } else if (!target.hasClass("jFloatable-absolute")) {
          target.removeClass("jFloatable-fixed").addClass("jFloatable-absolute").removeAttr("style");
          return setAbsolute(limit);
        }
      } else {
        return setInitialPosition();
      }
    };
    getInitialPosition = function() {
      originalData.offset = target.offset();
      return originalData.style = target.attr("style");
    };
    setInitialPosition = function() {
      target.removeClass("jFloatable-fixed").removeClass("jFloatable-absolute").removeAttr("style");
      target.attr("style", originalData.style);
      return originalData.offset = target.offset();
    };
    reset = function() {
      setInitialPosition();
      if (target.is(":visible") && base.isActive) {
        return windowScroll();
      }
    };
    turnOn = function(e) {
      e.preventDefault();
      e.stopPropagation();
      base.isActive = true;
      return reset();
    };
    turnOff = function(e) {
      e.preventDefault();
      e.stopPropagation();
      base.isActive = false;
      return setInitialPosition();
    };
    base.init = function() {
      var $window;

      base.options = $.extend({}, $.Jfloatable.defaultOptions, options);
      $window = $(window);
      getInitialPosition();
      maxTop = targetTop();
      $window.bind('scroll.jFloatable', windowScroll);
      $window.bind('resize.jFloatable', reset);
      target.bind('resize.jFloatable', windowScroll);
      target.bind('reset.jFloatable', reset);
      $window.bind('reset.jFloatable', reset);
      target.bind('off.jFloatable', turnOff);
      $window.bind('off.jFloatable', turnOff);
      target.bind('on.jFloatable', turnOn);
      $window.bind('on.jFloatable', turnOn);
      return windowScroll();
    };
    return base.init();
  };

  $.Jfloatable.defaultOptions = {
    limit: 0,
    top: 0,
    parentRelativeSelector: ".jFloatable-relative",
    fixedCss: {},
    absoluteCss: {}
  };

  $.fn.jFloatable = function(options) {
    return this.each(function() {
      return new $.Jfloatable(this, options);
    });
  };

}).call(this);
