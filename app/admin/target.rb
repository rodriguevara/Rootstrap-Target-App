ActiveAdmin.register Target do
  permit_params :title, :user_id, :radius, :lat, :lon, :topic_id, :created_at

  index do
    selectable_column
    id_column
    column :title
    column :user_id
    column :radius
    column :lat
    column :lon
    column :topic_id
    column :created_at

    actions
  end

  filter :id
  filter :title
  filter :user_id
  filter :radius
  filter :lat
  filter :lon
  filter :topic_id
  filter :created_at

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
