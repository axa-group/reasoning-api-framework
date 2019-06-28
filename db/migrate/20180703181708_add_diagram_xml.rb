class AddDiagramXml < ActiveRecord::Migration[5.2]
  def change
    add_column :statements, :diagram_xml, :longtext
  end
end
