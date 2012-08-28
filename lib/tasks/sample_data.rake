# coding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_categories
    make_products
    make_salegroups
    make_users
    make_contacts
  end
end

def make_categories
  Category.create!( kuvaus: "Lehdet",
                    salegroup_id: nil        
                  )
  Category.create!( kuvaus: "Liittymät",
                    salegroup_id: nil        
                  )
end

def make_products
  lehdet = Category.find_by_kuvaus("Lehdet")
  liittymat = Category.find_by_kuvaus("Liittymät")
   Product.create!( kuvaus: "Aku Ankka 7kk",
                    hinta: 37,
                    provisio: 10,
                    category_id: lehdet.id                    
                  )
   Product.create!( kuvaus: "Me Naiset 14kk",
                    hinta: 69,
                    provisio: 17,
                    category_id: lehdet.id                    
                  )
   Product.create!( kuvaus: "Aku Ankka 14kk",
                    hinta: 74,
                    provisio: 20,
                    category_id: lehdet.id                    
                  )
   Product.create!( kuvaus: "Me Naiset 7kk",
                    hinta: 35,
                    provisio: 9,
                    category_id: lehdet.id                    
                  ) 
    Product.create!( kuvaus: "Puhepaketti 250",
                    hinta: 20,
                    provisio: 9,
                    category_id: liittymat.id                    
                  )                                              
end

def make_salegroups
  lehdet = Category.find_by_kuvaus("Lehdet")
  liittymat = Category.find_by_kuvaus("Liittymät")
    Salegroup.create!(  nimi: "Lehtikauppiaat",
                        category_id: lehdet.id                      
                     )
    Salegroup.create!(  nimi: "Liittymäkauppiaat",
                        category_id: liittymat.id                      
                     )                 
end

def make_users
  lehtimyyjat = Salegroup.find_by_nimi("Lehtikauppiaat")
  liittymamyyjat = Salegroup.find_by_nimi("Liittymäkauppiaat")
   User.create!(  nimi: "Raikku Raikuttaja",
                  tunnus: "rairai",
                  password: "rairai",
                  password_confirmation: "rairai",
                  esimies: true,
                  salegroup_id: nil
                )
   User.create!(  nimi: "Miroslav Klousaaja",
                  tunnus: "mirklo",
                  password: "mirklo",
                  password_confirmation: "mirklo",
                  esimies: false,
                  salegroup_id: lehtimyyjat.id
                )
   User.create!(  nimi: "Sini Suloääni",
                  tunnus: "sinsul",
                  password: "sinsul",
                  password_confirmation: "sinsul",
                  esimies: false,
                  salegroup_id: lehtimyyjat.id
                )
   User.create!(  nimi: "Veijo Vastaväittelijä",
                  tunnus: "veivas",
                  password: "veivas",
                  password_confirmation: "veivas",
                  esimies: false,
                  salegroup_id: lehtimyyjat.id
                )
   User.create!(  nimi: "Arja Argumentoija",
                  tunnus: "arjarg",
                  password: "arjarg",
                  password_confirmation: "arjarg",
                  esimies: false,
                  salegroup_id: lehtimyyjat.id
                ) 
   User.create!(  nimi: "Tenho Tehomyyjä",
                  tunnus: "tenteh",
                  password: "tenteh",
                  password_confirmation: "tenteh",
                  esimies: false,
                  salegroup_id: lehtimyyjat.id
                )   
   User.create!(  nimi: "Kuisma Kuiskailija",
                  tunnus: "kuikui",
                  password: "kuikui",
                  password_confirmation: "kuikui",
                  esimies: false,
                  salegroup_id: liittymamyyjat.id
                )                                                             
end

def make_contacts
  ryhma = Salegroup.find_by_nimi("Lehtikauppiaat")
  lehtimyyjat = User.where(:salegroup_id => ryhma.id)
  tuotteet = Product.where(:category_id => ryhma.category_id)
  
  ryhma2 = Salegroup.find_by_nimi("Liittymäkauppiaat")
  liittymamyyjat = User.where(:salegroup_id => ryhma2.id)
  tuotteet2 = Product.where(:category_id => ryhma2.category_id)
  
  paivat = 6
  
  
  
  paivat.times do
    paiva = paivat.business_days.ago
    lehtimyyjat.each do |myyja|
      kontaktit = rand(20..50)
      pull = rand(0..25)
      kontaktit.times do
        if rand(0..100) < pull
          tuote = tuotteet[rand(tuotteet.length)]
          Contact.create!(
                    tilaus: true,
                    salegroup_id: myyja.salegroup_id,
                    user_id: myyja.id,
                    created_at: paiva,
                    updated_at: paiva                                     
          )
          Order.create!(
                    contact_id: Contact.last.id,  
                    hinta: tuote.hinta,
                    provisio: tuote.provisio,
                    kuvaus: tuote.kuvaus,
                    created_at: paiva,
                    updated_at: paiva,
                    user_id:  myyja.id
          )
          
        else
          Contact.create!(
                    tilaus: false,
                    salegroup_id: myyja.salegroup_id,
                    user_id: myyja.id,
                    created_at: paiva,
                    updated_at: paiva                                     
          )
        end  
      end
    end
    liittymamyyjat.each do |myyja|
      kontaktit = rand(20..50)
      pull = rand(0..25)
      kontaktit.times do
        if rand(0..100) < pull
          tuote = tuotteet2[rand(tuotteet2.length)]
          Contact.create!(
                    tilaus: true,
                    user_id: myyja.id,
                    salegroup_id: myyja.salegroup_id,
                    created_at: paiva,
                    updated_at: paiva                                     
          )
          Order.create!(
                    contact_id: Contact.last.id,  
                    hinta: tuote.hinta,
                    provisio: tuote.provisio,
                    kuvaus: tuote.kuvaus,
                    created_at: paiva,
                    updated_at: paiva,
                    user_id:  myyja.id
          )
          
        else
          Contact.create!(
                    tilaus: false,
                    user_id: myyja.id,
                    salegroup_id: myyja.salegroup_id,
                    created_at: paiva,
                    updated_at: paiva                                     
          )
        end  
      end
    end
    paivat = paivat - 1 
  end
  
end
