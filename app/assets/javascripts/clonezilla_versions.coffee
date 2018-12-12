$ ->
    $("a[data-remote]").on "ajas:success", (event) ->
        alert "That clonezilla version has been disabled"