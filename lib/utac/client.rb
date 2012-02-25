# encoding: utf-8

class Utac::Client
  include ::HTTParty
  
  base_uri Utac::Configuration::BASE_URL
  format :html
  headers({
      'User-Agent' => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.125 Safari/533.4"
  })
  
    
  DEPARTEMENT_PATH = "/fr/ctvl/lieu_ctrl_2.asp?rch=map&mot_cle="
  TABLE_OFFSET = 6
  
  def get_departement departement
    puts "get_departement #{departement}"
    
    res = get(DEPARTEMENT_PATH + departement.to_s)
    html = ::Nokogiri::HTML.parse(res.parsed_response)
    
    puts "request OK, start parsing ..."
    
    #test_xpth html
    
    Array.new.tap do |centers|
      table_index = 0
      error = false
      #puts "start parsing ..."
      total_percentage = 0
      while(!error) do
        begin
          c = ::Utac::Center.new
          
          #puts "try table #{table_index}"
          
          center_html = get_center_title(html, table_index).first
          if center_html
            title = center_html.content
            #matching = /^.*- (?<title>(['a-zA-Z]{1,}[ ]{0,1})+)\s*/.match(title)
            matching = /^.*- ((['a-zA-Z]{1,}[ ]{0,1})+)\s*/.match(title)
            #puts "match title #{matching.inspect} '#{matching[1]}'"
            c.name = matching[1] if matching
          
            data = get_center_data(html, table_index).first.content
            data = data.gsub!(/\s+/, ' ')
            data = data.gsub!(' ', ' ')
            #puts "title '#{title}',\ndata '#{data}'"
          
            c.eat_html_data data
            puts "Data : '#{data}'"# if c.per_centage == 0
            per_centage = c.per_centage
            puts "Center : #{per_centage}%"
            puts ""
            total_percentage += per_centage
            centers.push c
          else
            raise "no more center"
          end
        rescue Exception => e
          puts "exception #{e.message} #{e.backtrace}"#" ,\n#{e.backtrace}"
          error = true
        else
          #puts "next table ..."
          table_index += 1
        end
      end
      if centers.size != 0
        puts "Avrage success #{total_percentage / centers.size}% for #{centers.size} centers (sum #{total_percentage})"
      else
        puts "Failure : centers empty : #{centers}"
      end
    end
  end
  
  protected
  def test_xpth html
    puts "test_xpth"
    base = "/"
    xpath = "body/table[2]/tr[1]/td[3]/table[#{TABLE_OFFSET + 1}]/tr/td[@class='txtblack']" #
    i = 0
    xpath.split("/").each do |slice|
      base += "/#{slice}"
      puts "get #{base}"
      ex = html.xpath(base).to_s
      puts " > '#{ex}'" unless i == 0
      
      unless ex == "" || ex == nil
        File.open("extract.html", "w") do |f|
          f.write "get #{base} \n\n\n\n\n#{ex}"
        end
      end
      i += 1
    end
  end
  
  def get_center_title html, index=0
    html.xpath("//body/table[2]/tr[1]/td[3]/table[#{TABLE_OFFSET+index*2}]/tr/td[@class='txtbleubold']")
  end
  
  def get_center_data html, index=0
    html.xpath("//body/table[2]/tr[1]/td[3]/table[#{TABLE_OFFSET+1+index*2}]/tr/td[@class='txtblack']")
  end
  
  def catch_request *params, &block
    if [:get, :put, :post, :delete].include?(params.first)
      send_request *params, &block
    else
      super_method_missing *params, &block
    end
  end
  
  alias :super_method_missing :method_missing
  alias :method_missing :catch_request
  
  def send_request method, url, options={}
    begin
      self.class.send method, url, override_options(options)
    rescue Exception => e
      puts "Efactures client exception while #{method} #{url} :\n#{e.message}\n#{e.backtrace}"
      nil
    end
  end
  
  def override_options options={}
    options
  end
end