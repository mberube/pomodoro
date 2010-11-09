window.onload = function()
{
    var timeInterval = 25*60*1000
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
        // TODO play sound
        $('#finished').removeClass('hidden').addClass('visible')
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
