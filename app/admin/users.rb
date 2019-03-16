ActiveAdmin.register User do
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
    permit_params :username, :email, :password, :autosave
  index do 
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
    column :autosave
    column :stripe_charge_id
    actions
  end

  filter :username
  filter :email
  filter :note_shares
  filter :created_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :autosave
    end
    f.actions
  end
end
