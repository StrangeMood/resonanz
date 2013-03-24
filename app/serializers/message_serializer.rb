class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text

  has_one :author
end
