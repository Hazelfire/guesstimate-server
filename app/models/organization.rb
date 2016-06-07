class Organization < ActiveRecord::Base
  has_many :memberships, class_name: 'UserOrganizationMembership', dependent: :destroy
  has_many :members, through: :memberships, class_name: 'User', source: :user
  has_many :invitations, class_name: 'UserOrganizationInvitation', dependent: :destroy
  has_one :account, class_name: 'OrganizationAccount', dependent: :destroy

  has_many :spaces, dependent: :destroy

  belongs_to :admin, class_name: 'User'

  validates_presence_of :admin

  after_create :make_admin_member
  after_create :create_account
  after_create :begin_trial

  def prefers_private?
    true
  end

  private
  def make_admin_member
    memberships.create user: admin
  end

  def ensure_account
    account || create_account
  end
end
