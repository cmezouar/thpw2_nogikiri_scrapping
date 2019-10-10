require 'rubygems'
require 'nokogiri'         
require 'open-uri'

@page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
#puts page.class   # => Nokogiri::HTML::Document




def get_crypto_names
    symbols_array = []
    @page.xpath('//tr/td[@class = "text-left col-symbol"]').each do |symbol|
        symbols_array << symbol.text
    end
    return symbols_array
end

def get_crypto_values
    values_array = []
    @page.xpath('//tr/td/a[@class = "price"]').each do |value|
        values_array << value.text.gsub('$','')
    end
    return values_array
end

def result
    names = get_crypto_names
    values = get_crypto_values
    result = []
    
    result_hash = names.map.with_index do |name, index|
        new_hash = {}
        new_hash[name] = values[index]
        new_hash
    end

    result_hash.each do |hash|
        result << hash
        puts hash
    end

    return result
end


result

    