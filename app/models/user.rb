class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :recoverableand :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :events

  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email, :case_sensitive => false

  def admin?
    has_role?('admin')
  end

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin company project sales_quote sales_order purchase]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def has_role?(role)
    roles.include?(role)
  end

  def role_symbols
    roles.map(&:to_sym)
  end
end
