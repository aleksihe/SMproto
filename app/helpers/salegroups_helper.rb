module SalegroupsHelper
  def salegroup_nimi(salegroup_id)
   if salegroup_id == nil
     "Ei myyntiryhmaa"
   else
     nimi = Salegroup.find(salegroup_id).nimi
     nimi
   end
  end
  
end
