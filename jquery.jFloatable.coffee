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


  # initializer
  base.init = ->
    base.options = $.extend({}, $.Jfloatable.defaultOptions, options);

    target = base.$el
    console.log target

    #just fix in the top;
    css_fix =
      position: "fixed"
      top: 0

    target.css(css_fix)

  base.init()


# the default options

$.Jfloatable.defaultOptions = 
  limit: 0

$.fn.jFloatable = (options) ->
  this.each -> 
    new $.Jfloatable(this, options)