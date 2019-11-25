class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :phoneNumber, presence: true, uniqueness: true, length: { is: 9 }
    validates :address, presence: true, uniqueness: true
    validates :postalCode, presence: true, uniqueness: true
    validates :local, presence: true
    validates :link, presence: true, uniqueness: true
    validates :latitude, presence: true
    validates :longitude, presence: true

    scope :by_name, -> (name) { where(name: name) if name.present? }
    scope :by_local, -> (local) { where(local: local) if local.present? }
    scope :by_name_local, -> (name, local) { where(name:name, local: local) if local.present? && name.present? }
end
