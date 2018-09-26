$ ->
  $("a[data-remote]").on "ajax.success", (event) ->
    alert "The version of clonezilla has been modified."