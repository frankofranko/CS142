class TagsController < ApplicationController
    def new
        if params[:id] and Photo.exists?(params[:id])
            @tag = Tag.new()
            @photo =  Photo.find(params[:id])
            @user_list = []
            User.all.each do |user|
                @user_list.push([user.first_name+" "+user.last_name, user.id])
            end
        else
        
        end
    end
    
    def create
        @tag = Tag.new(tag_params(params[:tag]))
        puts "----------------------"
        puts @tag.attributes
        puts "----------------------"
        if @tag.save()
#            @user.errors.full_messages.each do|msg|
#                puts msg
#            end
            redirect_to(:controller => :photos, :action => :index, :id => @tag.photo.user_id)
        else
            puts @tag.errors.full_messages
            redirect_to(:controller => :tags, :action => :new, :id => @tag.photo.id)
        end
    end

    def tag_params(params)
        return params.permit(:tag,:photo_id,:x_pos,:y_pos,:width,:height,:user_id)
    end

end
