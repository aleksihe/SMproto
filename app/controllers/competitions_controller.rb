#coding: utf-8
class CompetitionsController < ApplicationController
  def new
    @users = User.where(:esimies => false)
    @competition = Competition.new
    3.times do 
     prize = @competition.prizes.build
    end
  end

  def create
   
     @competition = Competition.new(params[:competition])
     if @competition.save
       redirect_to competitions_path
     else
       flash[:error] = "Kilpaulun luominen epäonnistui"
       redirect_to competitions_new_path
     end
     
  end

  def destroy
    Competition.find(params[:id]).destroy
    redirect_to competitions_path
  end

  def index
    @competitions = Competition.all
  end
  def stringtodate(foo)
   paiva = foo[3..4]
   kuukausi = foo[0..1]
   vuosi = foo[6..9]
   DateTime.new(vuosi.to_i, kuukausi.to_i, paiva.to_i)
  end
end
