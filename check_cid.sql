select 
t.cid
,case when t.caldigit > 9 then t.caldigit - 10 else t.caldigit end caldigit
,t.checkdigit
,case when case when t.caldigit > 9 then t.caldigit - 10 else t.caldigit end = t.checkdigit then 'OK' else 'ERR' End result
from (
	 select cid,
	 11-(
	 (cast(substring(cid,1,1) as integer) * 13 +
	 cast(substring(cid,2,1) as integer) * 12 +
	 cast(substring(cid,3,1) as integer) * 11 +
	 cast(substring(cid,4,1) as integer) * 10 +

	 cast(substring(cid,5,1) as integer) * 9 +
	 cast(substring(cid,6,1) as integer) * 8 +
	 cast(substring(cid,7,1) as integer) * 7 +
	 cast(substring(cid,8,1) as integer) * 6 +

	 cast(substring(cid,9,1)  as integer) * 5 +
	 cast(substring(cid,10,1) as integer) * 4 +
	 cast(substring(cid,11,1) as integer) * 3 +
	 cast(substring(cid,12,1) as integer) * 2 )
		% 11) caldigit ,

	 cast(substring(cid,13,1) as integer)  checkdigit
	 from  your_table_name
	 where cid is not null and LENGTH(cid)=13
 ) t
