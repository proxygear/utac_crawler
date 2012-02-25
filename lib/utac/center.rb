# encoding: utf-8

class Utac::Center
  REGEXPS = {
    #:code => /d'agrément :.+(?<code>[0-9A-Z]{8}) \(/i,
    :code => {1 => /d'agr.ment :.+([0-9A-Z]{8}) \(/i},
    #:departement => /\( Département : (?<departement>[A-Za-z' ]+) \)/i,
    :departement => {1 => /\( Département : ([A-Za-z' ]+) \)/i},
    #:address => /\)(?<address>.+)Tél : /i,
    :address => {1 => /\)(.+)Tél : /i},
    #:phone => /Tél : (?<phone>[0-9]+)/i,
    :phone => {1 => /Tél : ([0-9]+)/i},
    #:group => /Enseigne : (?<group>[A-Z' ]+)/
    :group => {1 => /Enseigne : ([A-Z' ]+)/}
  }
  attr_accessor :name, :code, :departement, :address, :phone, :group
  
  def initialize
    
  end
  
  def eat_html_data data
    i = 0
    REGEXPS.each do |datum, regexp_config|
      regexp = regexp_config.values.first
      regexp_index = regexp_config.keys.first
      i +=1
      matching = regexp.match data
      if matching
        self.send "#{datum}=", matching[regexp_index]
      else
        puts "\t #{i}> Do not match with #{datum} #{regexp}"
      end
    end
  end
  
  def per_centage
    p = 0
    i = 0
    REGEXPS.each do |datum, regexp|
      i += 1
      p += 1 if self.send(datum) != nil
    end
    puts "center : #{p}/#{i}"
    p * 100 / REGEXPS.size
  end
end