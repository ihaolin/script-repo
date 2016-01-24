# MySQL IN Statement
* prevent from **Order By** of **IN Statement**
<pre>
	SELECT * FROM table_name WHERE column_name IN (val0, val1, val2,...) ORDER BY INSTR(',val0,val1,val2,...,',CONCAT(',', column_name, ',')); 
</pre>