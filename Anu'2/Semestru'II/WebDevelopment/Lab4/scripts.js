var requirementDiv = document.getElementById("requirement-p");
requirementDiv.style.fontSize = "35px";
requirementDiv.style.color = "grey";

var buttonDiv = document.getElementById("button-div");
buttonDiv.style.paddingLeft="40px";

var button = document.getElementById("btn");
button.style.backgroundColor="lightgreen";
button.style.borderRadius="5%"
button.style.height="5vh";
button.style.width="8vw";

var subMenuButton = document.getElementsByClassName("sub-menu-button");
for (var i = 0; i < subMenuButton.length; i++ )
{
    subMenuButton[i].style.backgroundColor= "lightyellow";
    subMenuButton[i].style.borderRadius = "5%";
    subMenuButton[i].style.height="5vh";
    subMenuButton[i].style.width="8vw";
}

var subMenuItem = document.getElementsByClassName("sub-menu-item");
for (var i = 0; i < subMenuItem.length; i++)
{
    subMenuItem[i].style.display = "flex";
}

var subMenuList = document.getElementById("sub-menu-list");
subMenuList.style.display = "none";
subMenuList.listStyleType = "none";
subMenuList.style.marginTop = "0px";

var componentsList = document.getElementsByClassName("components-list");
for (var i = 0; i < componentsList.length; i++)
{
    componentsList[i].style.paddingLeft = "0";
    componentsList[i].style.listStyleType = "none";
    componentsList[i].style.display = "none";
}

var componentButtons = document.getElementsByClassName("component-button");
for (var i = 0; i < componentButtons.length; i++)
{
    componentButtons[i].style.backgroundColor = "lightyellow";
    componentButtons[i].style.borderRadius = "5%";
    componentButtons[i].style.height = "5vh";
    componentButtons[i].style.width = "8vw";
}

function menuButtonClick(){
    var button = document.getElementById("btn");
    var listOfButtons = document.getElementById("sub-menu-list");
    var display = getComputedStyle(listOfButtons).display;
    if (display == "none") {
            listOfButtons.style.display = "block";
            button.style.background="limegreen"
        } else {
            listOfButtons.style.display = "none";
            button.style.background="lightgreen"
        }
}

function subMenuButtonClick(subBtn, cmpList){
    var str = "component-list"+cmpList;
    var component = document.getElementById("component-list"+cmpList);
    var listOfComponents = document.getElementsByClassName("components-list");
    var listOfButtons = document.getElementsByClassName("sub-menu-button");
    var display = getComputedStyle(component).display;
    if (display == "none"){
        component.style.display="block";
        subBtn.style.background="lightsteelblue"
        for (var i = 0; i < listOfComponents.length; i++)
        {
            if (listOfComponents[i].id != str)
            {
                listOfComponents[i].style.display = "none";
            }
        }
        for (var i = 0; i < listOfButtons.length; i++)
        {
            if (listOfButtons[i].id != subBtn.id)
            {
                listOfButtons[i].style.background = "lightyellow";
            }
        }
    }else{
        component.style.display="none";
        subBtn.style.background="lightyellow"
    }
}
