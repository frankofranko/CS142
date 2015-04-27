class Tag < ActiveRecord::Base
    belongs_to :user
    belongs_to :photo
    
    validates  :user_id, :photo_id, :x_pos, :y_pos,  :width, :height, :presence => true
end
