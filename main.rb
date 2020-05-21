require 'nokogiri'
require 'csv'

class AutoIRS
  COLUMNS = %w(NLinha Titular NIF CodEncargos AnoRealizacao MesRealizacao
               DiaRealizacao ValorRealizacao AnoAquisicao MesAquisicao DiaAquisicao
               ValorAquisicao DespesasEncargos PaisContraparte)

  def initialize(csv, xml)
    @csv = CSV.read(csv, headers: true)
    @xml = File.open(xml) { |f| Nokogiri::XML(f) }
    build_table
    new = File.open('new.xml', 'w') {|f| f.write(@xml.to_xml)}
  end

  private

  def build_table
    table = @xml.at('AnexoGq09T01')
    @csv.each_with_index do |row, index|
      parent_node = Nokogiri::XML::Node.new 'AnexoGq09T01-Linha', @xml
      parent_node["numero"] = index + 1
      COLUMNS.each do |col|
        child_node = Nokogiri::XML::Node.new col, parent_node
        if row[col] == nil
          number = 9000 + index + 1
          text = Nokogiri::XML::Text.new number.to_s, parent_node
        else
          text = Nokogiri::XML::Text.new row[col].to_s, parent_node
        end
        child_node.add_child(text)
        parent_node.add_child(child_node)
      end

      table.add_child(parent_node)
    end
  end
end

AutoIRS.new('quadro9.csv', 'test.xml')
