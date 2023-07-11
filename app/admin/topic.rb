ActiveAdmin.register Topic do
  permit_params :label, :image

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :label
      f.input :image, as: :file
    end
    f.actions
  end
  index do
    selectable_column
    id_column
    column :label
    column :image
    actions
  end

  show do
    attributes_table do
      row :label
      row :image
    end
  end
end
