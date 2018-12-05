$ ->
  $(".clickable-row").click ->
    window.location = $(this).data("href");
    
$ ->
  $(".gotoDoc").click ->
    link = document.getElementById('gotoDocLink').value
    if link.substring(0,3) != "http"
      link = "http://" + link
    window.open(link);