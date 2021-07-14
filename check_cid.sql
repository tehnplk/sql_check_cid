select 
data.cid
,case when data.caldigit > 9 then data.caldigit - 10 else data.caldigit end caldigit
,data.checkdigit
,case when case when data.caldigit > 9 then data.caldigit - 10 else data.caldigit end = data.checkdigit then 'OK' else 'ERR' End chk
from (
	 select t.cid,
	 11-(
	 (cast(substring(t.cid,1,1) as integer) * 13 +
	 cast(substring(t.cid,2,1) as integer) * 12 +
	 cast(substring(t.cid,3,1) as integer) * 11 +
	 cast(substring(t.cid,4,1) as integer) * 10 +

	 cast(substring(t.cid,5,1) as integer) * 9 +
	 cast(substring(t.cid,6,1) as integer) * 8 +
	 cast(substring(t.cid,7,1) as integer) * 7 +
	 cast(substring(t.cid,8,1) as integer) * 6 +

	 cast(substring(t.cid,9,1)  as integer) * 5 +
	 cast(substring(t.cid,10,1) as integer) * 4 +
	 cast(substring(t.cid,11,1) as integer) * 3 +
	 cast(substring(t.cid,12,1) as integer) * 2 )
		% 11) caldigit ,

	 cast(substring(t.cid,13,1) as integer)  checkdigit
	 from  log_queue t
	 where t.cid is not null and LENGTH(t.cid)=13
 ) data
