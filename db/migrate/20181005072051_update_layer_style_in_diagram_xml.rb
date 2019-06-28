class UpdateLayerStyleInDiagramXml < ActiveRecord::Migration[5.2]
  def change
    Statement.all.each do |s|
      s.diagram_xml.sub!(/\"layer\"/, "\"entity_cloud_layer\"")
      s.save
    end
  end
end
