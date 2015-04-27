function TableScan () {}


TableScan.sumColumn = function (table_id, column_name)
{
	var table = document.getElementById(table_id);
	if(table==null){
		console.log("Table not found.");	
		return 0;
	}

	var col_index = TableScan.getColumnIndex(table,column_name);
	if(col_index==-1){
		console.log("Column not found.");			
		return 0;
	}

	var sum = 0;
	var col_rows = table.rows;
	for(var i=1; i<col_rows.length; i++){
		var cell = col_rows[i].cells[col_index];
		if(cell!=null){
			var num = parseFloat(cell.textContent);
			if(!isNaN(num)&&(num.toString()==cell.textContent)) {sum+=num};
		}
	}

	return sum;

}

TableScan.getColumnIndex = function(table,colName){ //or initial colNum pos
	
	var col_names = table.rows[0].cells;
	for(var i=0;i<col_names.length;i++){
		if(col_names[i].textContent==colName)
			return i;
	}
	return -1;
}