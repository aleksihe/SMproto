
require 'spec_helper'

describe "Pages" do
  
  describe "esimies_main" do
    
    visit 'pages/esimies_main'
    page.should have_link("Kokonaismyynti", href: kokonaismyynti_path)
    page.should have_link("Myyntiryhmat", href: myyntiryhmat_path)
    page.should have_link("Kilpailut", href: kilpailut_path)
    page.should have_content("Placeholder")
    page.should have_content("Hallintapaneeli")
    page.should have_selector('h2', text: 'Yritys')
  end
end
