json.topics @topics do |topic|
  json.partial! 'topic', topic:
end
