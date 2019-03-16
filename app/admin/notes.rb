ActiveAdmin.register Note do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :user_id, :title, :description, :status, :important
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :created_at
    actions
  end

  filter :created_at
  filter :status
  filter :important
end
