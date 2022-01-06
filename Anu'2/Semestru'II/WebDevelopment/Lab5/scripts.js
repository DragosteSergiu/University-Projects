$(".main-wrapper").width("100%");
$(".main-wrapper").height("100vh");
$("#textBody").height("150vh");
$("#screen1").css('background-color', 'beige');
$("#screen2").css('background-color', 'azure');
$("#screen3").css('background-color', 'cornsilk');
$("#screen4").css('background-color', 'darkseagreen');
$("#screen2").css({display : 'none'});
$("#screen3").css({display : 'none'});
$("#screen4").css({display : 'none'});
$("#screen1").css({top : '0vh', left : '0vw', position : 'absolute'});
$("#screen2").css({top : '0vh', left : '-100vw', position : 'absolute'});
$("#screen3").css({top : '0vh', left : '-100vw', position : 'absolute'});
$("#screen4").css({top : '0vh', left : '-100vw', position : 'absolute'});
$(".screen").width("100%");
$(".screen").height("100%");
$("h1").css({textAlign : 'center'});
$("h1").css({marginTop : '5vh'});
$("h1").css({fontFamily : "Lucida Console, Courier New, monospace"});
$("p").css({margin : '7vh 4vw'});
$("p").css({fontSize : '20px'});
$("p").css({fontFamily : "Lucida Console, Courier New, monospace"});
$("ul").css({display : 'flex'});
$("ul").css({listStyleType : 'none'});
$("li").css({marginLeft : '5vw'});
$("img").css({height : '30vh', with : '40vw'});


function getOtherScreen(screen)
{
    if (screen == "1")
    {
        return "2";
    }
    else{
        if (screen == "2"){
            return "3";
        }
        else{
            if (screen == "3")
            {
                return "4";
            }
            else{
                if (screen == "4")
                {
                    return "1";
                }
            }
        }
    } 
}

const transitionTime = 2000;

function slide(screen)
{
    otherScreen = getOtherScreen(screen);
    $("#screen"+otherScreen).css({top : '0vh', left : '-100vw', position : 'absolute'});
    $("#screen"+screen).animate({left: "100vw"}, transitionTime);
    $("#screen"+otherScreen).css({display : 'block'});
    $("#screen"+otherScreen).animate({left: "0vw"}, transitionTime);
    setTimeout(changeDisplay, transitionTime, screen);
}

function changeDisplay(screen)
{
    $("#screen"+screen).css({display : 'none'});
}
