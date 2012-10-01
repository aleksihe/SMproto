# coding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_categories
    make_products
    make_salegroups
    make_users
    make_contacts
    make_goals
    make_competitions
    make_bonuses
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
  
  paivat = 30
  
  
  
  paivat.times do
    paiva = paivat.business_days.ago + 1.day
    lehtimyyjat.each do |myyja|
      kontaktit = rand(20..51)
      pull = rand(0..25)
      kontaktit.times do
        if rand(0..100) < pull
          tuote = tuotteet[rand(tuotteet.length)]
          Contact.create!(
                    tilaus: true,
                    salegroup_id: myyja.salegroup_id,
                    user_id: myyja.id,
                    tekija: myyja.nimi,
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
                    tekija: myyja.nimi,
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
                    tekija: myyja.nimi,
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
                    tekija: myyja.nimi,
                    created_at: paiva,
                    updated_at: paiva                                     
          )
        end  
      end
    end
    paivat = paivat - 1 
  end
end

def make_goals
  myyjat = User.where(:esimies => false)
  
  myyjat.each do |m|
    Goal.create!(
      user_id: m.id,
      salegroup_id: m.salegroup.id,
      alku: Time.zone.now.beginning_of_month,
      loppu: Time.zone.now.end_of_month,
      tyyppi: "Provisio(e)",
      maara: 2700.0
    )
    Goal.create!(
      user_id: m.id,
      salegroup_id: m.salegroup.id,
      alku: Time.zone.now.beginning_of_month,
      loppu: Time.zone.now.end_of_month,
      tyyppi: "Myynti(e)",
      maara: 9000.0
    )
    Goal.create!(
      user_id: m.id,
      salegroup_id: m.salegroup.id,
      alku: Time.zone.now.beginning_of_month,
      loppu: Time.zone.now.end_of_month,
      tyyppi: "Kontaktit(kpl)",
      maara: 800
    )
  end
end

def make_competitions
   #meneillään oleva kisa
   Competition.create!(
    nimi: "Riihikuivaa!",
    alku: Time.zone.now.beginning_of_month,
    loppu: Time.zone.now.end_of_month,
    saannot: "Kolme eniten provisiota ansainnutta myyjää palkitaan kuukauden lopussa riihikuivalla!",
    logiikka: 3
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "500€",
    arvo: 500.0
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "300€",
    arvo: 300.0
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "150€",
    arvo: 150.0
   )
   myyjat = User.where(:esimies => false)
   
   myyjat.each do |m|
     m.competitions = [Competition.last]
   end
   
   #päättynyt kisa  
   Competition.create!(
    nimi: "Lahjakorttiskaba",
    alku: Time.zone.now.beginning_of_month - 1.month,
    loppu: Time.zone.now.end_of_month - 1.month,
    saannot: "Kolme eniten myyntiä tehnyttä myyjää palkitaan mahtavilla lahjakorteilla!",
    logiikka: 1
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "Lahjakortti S-ryhmän kauppoihin 400€",
    arvo: 400.0
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "Lahjakortti S-ryhmän kauppoihin 200€",
    arvo: 200.0
   )
   Prize.create!(
    competition_id: Competition.last.id,
    kuvaus: "Lahjakortti S-ryhmän kauppoihin 150€",
    arvo: 150.0
   )
   
   myyjat.each do |m|
     m.competitions = m.competitions << Competition.last
   end
end

def make_bonuses
  salegroups = Salegroup.all
  
  salegroups.each do |s|
    Bonuslevel.create!(
      kriteeri: "myynti(e)",
      ehto: 5000,
      bonus_maara: 150,
      laji: "kkbonus",
      salegroup_id: s.id
    )
    Bonuslevel.create!(
      kriteeri: "myynti(e)",
      ehto: 8000,
      bonus_maara: 300,
      laji: "kkbonus",
      salegroup_id: s.id
    )
    Bonuslevel.create!(
      kriteeri: "myynti(e)",
      ehto: 11000,
      bonus_maara: 500,
      laji: "kkbonus",
      salegroup_id: s.id
    )     
  end
end
