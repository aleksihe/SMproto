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
 
 def paiva(date_time)
    date_time.day.to_s + "." + date_time.month.to_s + "." + date_time.year.to_s
 end

 def kuukausi_string(date_time)
   if date_time.month == 1
     return "Tammikuu"
   end
   if date_time.month == 2
     return "Helmikuu"
   end
   if date_time.month == 3
     return "Maaliskuu"
   end
   if date_time.month == 4
     return "Huhtikuu"
   end
   if date_time.month == 5
     return "Toukokuu"
   end
   if date_time.month == 6
     return "Kesäkuu"
   end
   if date_time.month == 7
     return "Heinäkuu"
   end
   if date_time.month == 8
     return "Elokuu"
   end
   if date_time.month == 9
     return "Syyskuu"
   end
   if date_time.month == 10
     return "Lokakuu"
   end
   if date_time.month == 11
     return "Marraskuu"
   end
   if date_time.month == 12
     return "Joulukuu"
   end
 end
end
