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
    @competitions = Competition.where("loppu > ?", Time.now)  
    @old_competitions = Competition.where("loppu < ?", Time.now) 
    if !@competitions.empty?
      @competition = @competitions.first
    end
    if !@old_competitions.empty?
      @old_competition = @old_competitions.first  
    end
    @old_competition = @old_competitions.first     
     @show_competition =  Competition.last
     if !@show_competition.nil?
      @osallistujat = @show_competition.users
      @saannot = @show_competition.saannot
      @palkinnot = @show_competition.prizes
      @palkinnot.sort!{|a,b| b.arvo <=> a.arvo }
    end
      
  end
  def stringtodate(foo)
   paiva = foo[3..4]
   kuukausi = foo[0..1]
   vuosi = foo[6..9]
   DateTime.new(vuosi.to_i, kuukausi.to_i, paiva.to_i)
  end
  
  def kilpailuvaihto
    @competitions = Competition.where("loppu > ?", Time.now)
    @old_competitions = Competition.where("loppu < ?", Time.now)
    @show_competition = Competition.find(params[:competition_id])
    @osallistujat = @show_competition.users
    @saannot = @show_competition.saannot
    @palkinnot = @show_competition.prizes
    @palkinnot.sort!{|a,b| a.arvo <=> b.arvo }
    respond_to do |format|
      format.js
    end
  end
end
