//// square = (x) -> x * x
//// alert square(10)

$(document).ready ->
    $.ajax(url: "/").done (html) ->
      $("#results").append html
