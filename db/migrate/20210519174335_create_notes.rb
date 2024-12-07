class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content # Si esto está presente, elimina la migración duplicada
      t.text :body

      t.timestamps
    end
  end
end
