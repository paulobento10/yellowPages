class User < ApplicationRecord
    validates :phoneNumber, presence: true, uniqueness: true, length: { is: 9 }
    scope :by_name, -> (name) { where(name: name) if name.present? }
    scope :by_local, -> (local) { where(local: local) if local.present? }
    scope :by_name_local, -> (name, local) { where(name:name, local: local) if local.present? && name.present? }
    #scope :by_updateCounter, -> (id) { where(id:id) if id.present? }
    #def by_updateCounter
    #    update_attributes(:counter => counter + 1)
    #end
end
