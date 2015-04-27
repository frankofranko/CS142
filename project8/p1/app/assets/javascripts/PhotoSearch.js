

function PhotoSearch( searchTextId, searchResultId ) {

	this.searchText = document.getElementById(searchTextId);
    this.searchResult = document.getElementById(searchResultId);

    console.log(this.searchResult)
    var obj = this
    this.searchText.onkeyup = function(event){
        obj.keyUp(event);
    }

}

PhotoSearch.prototype.keyUp = function (event){

	// console.log("key change")
	var searchWord = this.searchText.value

	var url_head = "/photos/search"
	var url_param = "search_text="+searchWord
	var request_body = url_head+"?"+url_param

	var request = new XMLHttpRequest();
	var obj = this;
    request.onreadystatechange = function () {
        if ((this.readyState != 4)||(this.status != 200))
            return;
        obj.searchResult.innerHTML = ""
        // console.log(this.responseText);
        var resultArray = JSON.parse(this.responseText)
        
        for (var i=0; i < resultArray.length; i++){
        	var photo_result = resultArray[i];
				// console.log("id:"+photo_result
			var newDiv = document.createElement("DIV");

            newDiv.innerHTML =  "<a href=\"/photos/index/"+photo_result[1]+"?photo_search="+photo_result[0]+"\">"+"<span class=\"searchImg\" style=\"background-image: url('"+photo_result[2]+"');\"></span></a>";
                             
            obj.searchResult.appendChild(newDiv);
        }
    }

    request.open("GET", request_body, true);
    request.send();

}
