class CommentsController < ApplicationController

    def new
        if Photo.exists?(:id => params[:id])
            puts "photo exists"
            @photo = Photo.find(params[:id])
            @comment = Comment.new()
        else
            puts "photo not exists"
        end
    end
    
    def create
        @comment = Comment.new(comment_params(params[:comment]))
        @comment.photo_id = params[:id]
        @comment.user_id = session["user"]
        @comment.date_time = Time.current
        @comment.photo = Photo.find(@comment.photo_id)

        if @comment.save()
            redirect_to(:controller => :photos, :action => :index, :id => Photo.find(params[:id]).user_id)
        else
            flash[:error] = "Comment cannot be blank."
            redirect_to(:controller => :comments, :action => :new, :id => params[:id])
        end
    end

    private
    
    def comment_params(params)
        return params.permit(:comment)
    end

end
