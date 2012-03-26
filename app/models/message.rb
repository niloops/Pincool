class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, type: Symbol
  field :sender_ids, type: Array
  field :read, type: Boolean, default: false
  belongs_to :post
  embedded_in :user, inverse_of: :messages

  validates_inclusion_of :type, in: [:comment]

  scope :by_post, ->(post, type) do
    where(type: type).and(post_id: post.id)
  end
  scope :unreads, where(read: false)
  default_scope desc(:created_at)

  class << self
    def build_comment(sender, post)
      new type: :comment,
      sender_ids: [sender.id],
      post: post
    end

    def read_comment(user, post)
      message = user.messages.by_post(post, :comment).first
      message && message.read!
    end

    def readall(user)
      user.messages.unreads.each {|message| message.read!}
    end
  end

  def send_to(receiver)
    message_exist = send "find_#{type}", receiver
    if message_exist
      self.sender_ids += message_exist.sender_ids
      self.sender_ids.uniq!
      message_exist.destroy
    end
    receiver.messages << self
    receiver.messages.first.delete if receiver.messages.length > 99
  end

  def find_comment(user)
    user.messages.by_post(post, :comment).first
  end

  def senders
    sender_ids.map {|id| User.find(id)}
  end

  def read!
    update_attributes read: true
  end
end
