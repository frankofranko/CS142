class PhotosController < ApplicationController
    def index
        if params[:id] and User.exists?(params[:id])
            @user = User.find(params[:id])
        end
    end

  	def new

    	@photo = Photo.new(params[:photo])

  	end

  	def create
  		puts "photo create---------"
  		@photo = Photo.new(photo_params(params[:photo]))
  		@photo.user_id = session[:user]
  		@photo.file_name = params[:photo][:file].original_filename
  		@photo.date_time = DateTime.now
  		if @photo.save()
	    	File.open(Rails.root.join('app', 'assets', 'images', params[:photo][:file].original_filename), 'wb') do |file|
	    		file.write(params[:photo][:file].read())
	    	end
	    	redirect_to(:controller => :photos, :action => :index, :id => session[:user])
		else 
			flash[:error] = "upload error."
			redirect_to(:controller => :photos, :action => :new)
		end
  	end

	private
    
    def photo_params(params)
        return params.permit(:photo)
    end

end
