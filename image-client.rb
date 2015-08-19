# -*- encoding : utf-8 -*-
require 'rubygems'
require 'scanf'
require 'typhoeus' #http lib
require 'nokogiri' #html parser
require 'csv'
require 'timeout'
require 'to_xls'
require 'mail'

#Test Setting
TEST_TIME_PER_SEC = 5
TRY_TIME = 1

#ESun Setting 
# IMAGE_TEST_URL = 'http://192.168.56.101:9292/'
IMAGE_TEST_URL = 'http://127.0.0.1:9000/'
IMAGE_PATH = './Number5000/'
# CUS_NAME = "admin"
CUS_NAME = "test"

#curl -F user="admin" -F "file=@astronaut.jpg" http://192.168.56.101:9292/save_image
#response = `curl -X POST -d '#{doc.to_xml}' '#{@invoiceurl}'`
#response = `curl '127.0.0.1:3000/einvoice/set_sellerinfo?possn=123&posid=456&sellerid=789&appversion=000'`

=begin
timer_thread = []

TRY_TIME = 200
TRY_TIME.times do |index|
  timer_thread[index] = Thread.new do
    image_num = 0
    loop do
      image_num = image_num + 1
      puts "index:#{index}num " + image_num.to_s
    end
  end
end

TRY_TIME = 200
TRY_TIME.times do |index|
  timer_thread[index].join
end
=end



timer_thread = []

TRY_TIME.times do |index|
  timer_thread[index] = Thread.new do
    image_num = 0
    loop do
      image_num = image_num + 1
      begin
        Timeout.timeout(TEST_TIME_PER_SEC) { sleep } #trigger timer ever TEST_TIME_PER_SEC 
      rescue Timeout::Error
        image_name = IMAGE_PATH + image_num.to_s.rjust(5,'0') + '.jpg'
        puts "album:#{index}, image_name:#{image_name}"
        

        response = `curl -F user="admin" -F album="#{index}" -F "file=@#{image_name}" http://127.0.0.1:9000/save_image`
        puts response
      end      
    end
  end
end

TRY_TIME.times do |index|
  timer_thread[index].join
end


