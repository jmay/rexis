Sequel.migration do
  change do
    create_table :codes do
      primary_key :id
      foreign_key :item_id, :registry

      String :code, null: true, index: true, unique: true

      Time   :created_at, null: false
      Time   :expires_at, null: true
    end
  end
end
