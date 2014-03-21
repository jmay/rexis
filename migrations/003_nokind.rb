Sequel.migration do
  up do
    drop_column :registry, :kind
    drop_column :registry, :code
  end
end
