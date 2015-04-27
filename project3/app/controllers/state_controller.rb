class StateController < ApplicationController
  def filter

  	if params[:substring]
  		@substring = params[:substring]
  		@result = State.filter(@substring)
  	end

  end
end
