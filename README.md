# jFloatable

jFloatable is a jQuery plugin that allows you to fix elements in the screen and delimitates when it should be unfixed.

## Basics

Default options:

```
{
  limit: 0, // when the fix should stops
  top: 0, // margin top after fixed
  fixedCss: {}, // css to be added when the element is fixed
  absoluteCss: {} // css to be added when the element is absolute
  parentRelativeSelector: ".jFloatable-relative", // selector of a parent that has its position relative
}
```

## How it works

The element will be fixed when the window offset top touches its top offset.
If there is a limit in the configuration when the window offset top touches this limit the element will be set to absolute.

As it can have an absolute position the plugin offers the opportunity to set which parent you want for this position.

## Usage

```
$middle = $("#middle")

$("#top").jFloatable({
  limit: $middle.offset().top,
  fixedCss: {
    border: '2px dotted green'
  },
  absoluteCss: {
    border: '1px dotted blue'
  }
});

$middle.jFloatable({
  top: 50
});
```
(demo)[http://ruanltbg.github.io/jFloatable/]
