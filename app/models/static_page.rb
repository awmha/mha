class StaticPage < ApplicationRecord
  store :social_media, accessors: [ "facebook", "twitter" ]

end