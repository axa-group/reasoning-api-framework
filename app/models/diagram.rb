class Diagram
  include ActiveModel::Validations

  def initialize(xml)
    @xml_root = Nokogiri::XML(xml).root
  end

  def connections
    puts "size: #{@xml_root.xpath(".//mxCell[@edge=1]")}"
    @xml_root.xpath(".//mxCell[@edge=1]").map do |e|
      color = e["style"].scan(/.*strokeColor=([A-Za-z0-9#]+).*/).flatten.try(:first)
      puts "e: #{e}"
      source = get_metadata_by_id(e["source"])
      target = get_metadata_by_id(e["target"])
      [source["timestamp"], target["timestamp"], color]
    end
  end

  def get_metadata_by_id(id)
    @xml_root.xpath(".//metadata[@id=#{id}]").first
  end
end