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


# the default options

$.jFloatable.defaultOptiomns = 
  limit: 0

$.fn.jFloatable = (options) ->
  this.each -> 
    new $.Jfloatable(this, options)