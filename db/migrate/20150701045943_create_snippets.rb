class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :snippet_text
      t.boolean :private
      t.string :slug

      t.timestamps
    end
  end
end
