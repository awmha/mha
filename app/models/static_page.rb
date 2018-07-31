class StaticPage < ApplicationRecord
  store :social_media, accessors: [ "facebook", "twitter" ]
  mount_uploader :logo, PictureUploader
  mount_uploader :favicon, PictureUploader

end