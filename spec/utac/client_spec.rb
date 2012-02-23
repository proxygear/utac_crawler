require 'spec_helper'

describe Utac::Client do
  let (:client) {Utac::Client.new}
  
  it 'should build centers by departement' do
    res = client.get_departement 60
    puts "res : #{res}"
  end
end