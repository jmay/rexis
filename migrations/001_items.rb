Sequel.migration do
  change do
    create_table :registry do
      primary_key :id

      String :kind,       null: false
      String :url,        null: false
      String :token,      null: false, index: true, unique: true
      String :code,       null: true, index: true, unique: true

      Time   :created_at, null: false
      Time   :updated_at, null: true
    end
  end
end
