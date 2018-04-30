class StaticPage < ApplicationRecord
  store :social_media, accessors: [ "facebook", "twitter" ]
  mount_uploader :logo, PictureUploader

end