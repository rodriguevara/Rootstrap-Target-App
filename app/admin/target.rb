ActiveAdmin.register Target do
  permit_params :title, :user_id, :radius, :lat, :lon, :topic_id, :created_at

  filter :id, as: :select
  filter :title
  filter :user, as: :select, collection: User.all.pluck(:email, :id)
  filter :radius
  filter :lat
  filter :lon
  filter :topic, as: :select, collection: Topic.all.pluck(:label, :id), multiple: true
  filter :created_at

  index do
    selectable_column
    id_column
    column :title
    column 'User' do |m|
      User.find(m.user_id).email
    end
    column :radius
    column :lat
    column :lon
    column 'Topic' do |m|
      Topic.find(m.topic_id).label
    end
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :user_id
      row :radius
      row :lat
      row :lon
      row :topic_id
      row :created_at
    end
  end
end
