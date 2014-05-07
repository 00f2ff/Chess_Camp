class HomeController < ApplicationController
	# check authorization
  #authorize_resource
  
  def index
    @quotes = ["Chess, like love, like music, has the power to make us happy.", 
      "Chess is not merely an idle amusement ... life is a kind of chess.", 
      "Chess is a game which reflects most honor on human wit.",
      "The game of chess is the touchstone of the intellect.",
      "Chess is intellectual karate.",
      "Chess is the gymnasium of the mind.",
      "Checkers is for tramps.",
      "Chess is an international language.",
      "Modern chess is too much concerned with things like pawn structure. Forget it - checkmate ends the game",
      "There just isn't enough televised chess."]
    @authors = ["Dr. Siegbert Tarrasch (GM)",
      "Benjamin Franklin",
      "Francois Voltaire",
      "Johann von Goethe",
      "GM Maurice Ashley",
      "Blaise Pascal",
      "Paul Morphy",
      "Emanuel Lasker, World Chess Champion from 1894-1921",
      "GM Nigel Short",
      "David Letterman"]
    @upcoming_camps = Camp.active.upcoming.chronological.paginate(:page => params[:page]).per_page(10)
    @instructors = Instructor.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
