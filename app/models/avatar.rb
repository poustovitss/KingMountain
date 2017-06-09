class Avatar < ApplicationRecord
  belongs_to :user

   has_attached_file :image,
                    styles: { medium: '100x100>', thumb: '200x200>'},
                    default_url: '/images/:style/missing.png'
   validates_attachment_content_type :image, 
                    content_type: ['image/jpeg', 'image/gif', 'image/png']

end
