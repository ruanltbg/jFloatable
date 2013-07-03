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
  originalData =
    offset: null
    style: null
  
  base.isActive = true


  getScrollTop = ->
    ( if (window.pageYOffset != undefined) then window.pageYOffset else document.documentElement.scrollTop )

  targetTop = ->
    target.offset().top - parseFloat(target.css('marginTop').replace(/auto/, 0)) - base.options.top

  setFix = ()->

    cssBase = 
      position: 'fixed'
      top: base.options.top
      left: originalData.offset.left

    css = $.extend({}, cssBase, base.options.fixedCss);
    target.css(css)

  setAbsolute = (limit)->
    cssBase = 
      position: 'absolute'
      top: limit - originalData.offset.top
    css = $.extend({}, cssBase, base.options.absoluteCss);

    target.css(css)

  getLimit = ->
    # if limit was setted
    if base.options.limit > 0
      base.options.limit - target.outerHeight()
    else
      $(document).outerHeight() - target.outerHeight()


  windowScroll = ->
    # if it is not active should stop
    return false unless base.isActive
    windowScrollTop  = getScrollTop()
    limit = getLimit();

    # if the scroll passed the original top
    # maxTop is the targetOriginalTop
    if windowScrollTop >= maxTop
      if windowScrollTop < limit
        if !target.hasClass("jFloatable-fixed") 
          # add the fixed class and remove the style created by the scrolling
          # it detach the target from the screen
          target.removeClass("jFloatable-absolute").addClass("jFloatable-fixed").removeAttr("style");
          setFix()
      else if !target.hasClass("jFloatable-absolute")
        # it reach the limit
        target.removeClass("jFloatable-fixed").addClass("jFloatable-absolute").removeAttr("style")
        setAbsolute(limit)
    else
      setInitialPosition()

  getInitialPosition = ->
    originalData.offset = target.offset()
    originalData.style = target.attr("style")

  setInitialPosition = ->
    target.removeClass("jFloatable-fixed").removeClass("jFloatable-absolute").removeAttr("style")
    target.attr("style", originalData.style)
    originalData.offset = target.offset()

  reset = ->
    setInitialPosition();
    if target.is(":visible") and base.isActive
      windowScroll();

  turnOn = (e) -> 
    e.preventDefault()
    e.stopPropagation()
    #console.log e
    base.isActive = true
    reset()

  turnOff = (e) ->
    e.preventDefault()
    e.stopPropagation()
    #console.log e
    base.isActive = false
    setInitialPosition()


  # initializer
  base.init = ->
    base.options = $.extend({}, $.Jfloatable.defaultOptions, options);
    $window = $(window)


    getInitialPosition()
    maxTop = targetTop()

    # fix or unfix the target when the window scrolls
    $window.bind('scroll.jFloatable', windowScroll)
    $window.bind('resize.jFloatable', reset)
    target.bind('resize.jFloatable', windowScroll)

    target.bind('reset.jFloatable', reset)
    $window.bind('reset.jFloatable', reset)

    target.bind('off.jFloatable', turnOff)
    $window.bind('off.jFloatable', turnOff)

    target.bind('on.jFloatable', turnOn)
    $window.bind('on.jFloatable', turnOn)

    windowScroll()

  base.init()


# the default options

$.Jfloatable.defaultOptions = 
  limit: 0
  top: 0
  fixedCss: {}
  absoluteCss: {}

$.fn.jFloatable = (options) ->
  this.each -> 
    new $.Jfloatable(this, options)