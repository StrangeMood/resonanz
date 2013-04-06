messages = messages.includes(:author) if messages.is_a?(ActiveRecord::Relation)

json.array! messages do |message|
  json.cache! message do
    json.partial! message
  end
end