class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :nimi
      t.datetime :alku
      t.datetime :loppu
      t.integer :palkintosijat
      t.text :saannot
      t.integer :logiikka

      t.timestamps
    end
  end
end
