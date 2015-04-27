function Calendar(id)
{
	this.element = document.getElementById(id);
}


Calendar.prototype.render = function(date)
{

	this.element.innerHTML = ''; 

	var table=document.createElement('table');
  
	this.element.appendChild(table);
  
	// for table title
	var monthNames=['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

	var title=document.createElement('caption');
	title.appendChild(document.createTextNode(monthNames[date.getMonth()] + "," + date.getFullYear()));

	var prev=document.createElement('a');
  	var next=document.createElement('a');
  	prev.setAttribute('href', '');
  	next.setAttribute('href', '');
  	prev.appendChild(document.createTextNode('<')); 
  	next.appendChild(document.createTextNode('>')); 

	var calendar = this;
  	prev.onclick=function(event){
		calendar.render( new Date(date.getFullYear(), date.getMonth()-1, 1) );
       	event.preventDefault();
	}
	next.onclick=function(event){
		calendar.render( new Date(date.getFullYear(), date.getMonth()+1, 1) );
       	event.preventDefault();
	}

	title.insertBefore(prev,title.childNodes[0]);
	title.appendChild(next);
	table.appendChild(title);

	// for week day names
	var tr = Calendar.createWeekNameTr();
	table.appendChild(tr);


	// for days
	var curDay = new Date(date.getFullYear(), date.getMonth(),  1);
	var monthCount = -1;
	if(curDay.getDay()!=0){
		curDay.setDate(curDay.getDate()-1);
		curDay.setDate(curDay.getDate()-curDay.getDay());
	}
	var curMonth = curDay.getMonth();
	var lastMonth = curDay.getMonth();
	var dayCount =0;

	while(lastMonth==curMonth || dayCount<28) {
		tr=document.createElement('tr');
		lastMonth = curDay.getMonth();
		for (j=0;j<7; j++){
			td=document.createElement('td');
			if(curDay.getDate()==1){monthCount+=1;}
			if(monthCount!=0){td.setAttribute('class', 'dim');}
		
			td.appendChild(document.createTextNode(curDay.getDate())); 
			// console.log(curDay.getDate());
			tr.appendChild(td);
			curDay.setDate(curDay.getDate() + 1);
			curMonth = curDay.getMonth();
			
			dayCount += 1;
		}
		table.appendChild(tr);
		
		
	}

}





Calendar.createWeekNameTr = function()
{
	var tr=document.createElement('tr');
  	var days=['Su ', 'Mo ', 'Tu ', 'We ', 'Th ', 'Fr ', 'Sa ', 'Su '];

	for (i=0;i<7; i++) {
     	var td = document.createElement('td');
    	td.appendChild(document.createTextNode(days[i])); 
    	tr.appendChild(td);
	}

	return tr;

}
