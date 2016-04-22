class Housefile < ActiveRecord::Base
  belongs_to :house
mount_uploader :file, HousefileUploader, :mount_on => :file_name

end
