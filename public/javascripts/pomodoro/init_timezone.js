window.onload = function()
{
    if(!$.cookie("tzoffset")) {
        var offset = (new Date()).getTimezoneOffset()
        $.cookie("tzoffset", offset);
    }
}