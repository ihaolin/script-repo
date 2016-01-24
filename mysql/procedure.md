# Pocedure
* create a procedure
<pre>create procedure insert_city(_name varchar(20), out _id int)
	begin
		insert into city value(null, _name);
		select max(cityID) into _id from city;
	end;
</pre>
* show a procedure
<pre>
	show create procedure insert_city;
</pre>
* delete a procedure
<pre>
	drop procedure insert_city
</pre>