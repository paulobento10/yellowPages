class User < ApplicationRecord
    #has_one_attached :image
    mount_uploader :avatar, AvatarUploader
    validates :phoneNumber, presence: true, uniqueness: true, length: { is: 9 }

    scope :by_name, -> (name) { where(name: name) if name.present? }
    scope :by_local, -> (local) { where(local: local) if local.present? }
    scope :by_name_local, -> (name, local) { where(name:name, local: local) if local.present? && name.present? }
end
