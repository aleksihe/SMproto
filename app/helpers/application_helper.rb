#coding: utf-8
module ApplicationHelper
 def paiva_klo(date_time)
   if date_time.min < 10
     @minuutit = "0" + date_time.min.to_s
   else
     @minuutit = date_time.min.to_s
   end
   
   if date_time.hour < 10
     @tunnit = "0" + date_time.hour.to_s
   else
     @tunnit = date_time.hour.to_s
   end
   date_time.day.to_s + "." + date_time.month.to_s + "." + date_time.year.to_s + " " + @tunnit + ":" + @minuutit   
 end
 
end
