var bound = false;
var pjs; //contains the processing sketch	

function bindJavascript() {
	pjs = Processing.getInstanceById('devarcs');
	if(pjs!=null) {
		pjs.bindJavascript(this);
		bound = true; }
		if(!bound) setTimeout(bindJavascript, 250);
};

bindJavascript();

var buildData = {};
setInterval(function(){
	$.getJSON('faux_display.json', function(data){
	buildData = data;	
		if(pjs){
			updateDisplay();
		}
	}).error(function(){console.log("Error fetching build data")});
},15000);


var updateDisplay = function(){
	var index;
	var dev;
	for(d in buildData.users){
	    if(buildData.users.hasOwnProperty(d)){
	        index = pjs.getDevByName(d);
	        if(index != -1){ //if the dev is found
	        	dev = pjs.getDev(index); //processing devArc object

	        	dev.setTotalItems(buildData.users[d].item_total);	
	        	dev.setCompletedItems(buildData.users[d].item_complete);

	        }
	    }
	}
}