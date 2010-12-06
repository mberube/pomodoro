function getMethods(obj) {
  var result = [];
  for (var id in obj) {
    try {
      if (typeof(obj[id]) == "function") {
        result.push(id + ": " + obj[id].toString());
      }
    } catch (err) {
      result.push(id + ": inaccessible");
    }
  }
  return result;
}

window.onload = function()
{
    var timeInterval = parseInt(jQuery.trim($('#init-value').text()))
    //var timeInterval = 3*1000
    var endTime = new Date(new Date().getTime() + timeInterval)
    tick(endTime)
}

/**
 *
 * @param endTime Date object at which the timer will end
 */
function tick(endTime)
{
    var now = new Date();
    var interval = endTime.getTime() - now.getTime();
    var timeToDisplay = formatTime(interval)
    $('#timer').html(timeToDisplay)

    if(interval > 0) {
        var nextTick = function() {
            tick(endTime)
        }
        setTimeout(nextTick, 100)
    } else {
        $('#finished').removeClass('hidden').addClass('visible')

        $("#jplayer").jPlayer( {
            ready: function () {
              this.element.jPlayer("setFile", "/sounds/beep.mp3").jPlayer("play")
            },
            swfPath: "/sounds",
            preload: "auto"
        });
    }
}

/**
 * @param interval interval to display in milliseconds
 */
function formatTime(interval) {
    var remainingTimeInSeconds = parseInt(interval/1000);
    var s = parseInt(remainingTimeInSeconds%60)
    remainingTimeInSeconds = parseInt(remainingTimeInSeconds / 60)
    var m = parseInt(remainingTimeInSeconds%60)
    remainingTimeInSeconds = parseInt(remainingTimeInSeconds / 60);
    var h = parseInt(remainingTimeInSeconds)

    // add zero in front of number < 10
    var timeToDisplay = fillWithZero(m)+":" + fillWithZero(s);
    if(h > 0) {
        timeToDisplay = h+":" + timeToDisplay
    }
    return timeToDisplay
}

function fillWithZero(i)
{
    if(i<10) {
        i = "0" + i;
    }
    return i;
}
