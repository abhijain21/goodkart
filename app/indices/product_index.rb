ThinkingSphinx::Index.define :product, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes category.name, :as => 'category_name'
  # attributes
  has created_at, updated_at
  has category_id, :facet => true
  group_by "category_id"
end