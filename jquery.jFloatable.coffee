# verify if the element already has the jFloatable plugin actived
$.isJfloatable = (el) ->
  $(el).data("jFloatable") != undefined;

$.Jfloatable = (el, options) ->
  # To avoid scope issues, use 'base' instead of 'this' to reference this
  # class from internal events and functions.
  base = this

  #acess to jQuery and DOM versions of element.
  base.$el = $(el)
  base.el = el;

  #add a reverse reference to the DOM object.
  base.$el.data("jFloatable", base)


  # properties
  target = base.$el
  maxTop = null
  originalOffset = null


  getScrollTop = ->
    ( if (window.pageYOffset != undefined) then window.pageYOffset else document.documentElement.scrollTop )

  targetTop = ->
    target.offset().top - parseFloat(target.css('marginTop').replace(/auto/, 0)) - base.options.top

  setFix = ()->
    css = 
      position: 'fixed'
      top: base.options.top
      left: originalOffset.left
    target.css(css)

  setAbsolute = (scrollTop)->
    css = 
      position: 'absolute'
      top: scrollTop - originalOffset.top
    target.css(css)

  getLimit = ->
    # if limit was setted
    if base.options.limit > 0
      base.options.limit - target.outerHeight()
    else
      $(document).outerHeight() - target.outerHeight()


  windowScroll = ->
    scrollTop = getScrollTop()
    #limit     = getLimit();

    if scrollTop >= maxTop
      if scrollTop < getLimit()
        # add the fixed class and remove the style created by the scrolling
        # it detach the target from the screen
        target.removeClass("jFloatable-absolute").addClass("jFloatable-fixed").removeAttr("style");
        setFix()
      else if !target.hasClass("jFloatable-absolute")
        # it fix the target in the screen
        target.removeClass("jFloatable-fixed").addClass("jFloatable-absolute").removeAttr("style")
        setAbsolute(scrollTop)
    else
      target.removeClass("jFloatable-fixed").removeClass("jFloatable-absolute").removeAttr("style")


  # initializer
  base.init = ->
    base.options = $.extend({}, $.Jfloatable.defaultOptions, options);

    originalOffset = $.extend({}, target.offset());
    maxTop = targetTop()

    # fix or unfix the target when the window scrolls
    $(window).bind('scroll.jFloatable', windowScroll);


  base.init()


# the default options

$.Jfloatable.defaultOptions = 
  limit: 0
  top: 0

$.fn.jFloatable = (options) ->
  this.each -> 
    new $.Jfloatable(this, options)