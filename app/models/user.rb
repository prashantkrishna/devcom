class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :work_experiences, dependent: :destroy
  has_many :connections, dependent: :destroy

  PROFILE_TITLE = [
    'Senior Ruby on Rails Developer',
    'junior Ruby on Rails Developer',
    'Senior full Stack Ruby on Rails Developer',
    'junior full Stack Ruby on Rails Developer',
    'Frontend Developer',
    'Backend Developer',
    'Project manager'
  ].freeze

    def name
      "#{first_name} #{last_name}".strip
    end

    def self.ransackable_attributes(auth_object = nil)
      ["country", "city"]
    end

    def self.ransackable_associations(auth_object = nil)
      []
    end

    def address
      "#{city}, #{state}, #{country}, #{pincode}"
    end

    def my_connection(user)
      Connection.where("(user_id = ? AND connected_user_id = ?) OR (user_id =? AND connected_user_id = ?)", user.id, id, id, user.id)
    end

    def check_if_already_connected?(user)
      self != user && !my_connection(user).present?
    end
end
