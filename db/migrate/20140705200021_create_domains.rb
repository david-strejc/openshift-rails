class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.text :description
      t.text :cartridge
      t.text :initial_git_url

      t.timestamps
    end
  end
end
