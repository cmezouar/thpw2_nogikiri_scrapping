require 'nokogiri'         
require 'open-uri'

def townhalls_urls
    @page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    town_urls_array = []
    @page.xpath('//tr/td/p/a[@class= "lientxt"]/@href').each do |url|
        town_urls_array << url.text.gsub("./95/","")
    end
    return town_urls_array
end

def towns_names
    urls_array = townhalls_urls
    size = urls_array.size
    towns_names_array = []
    for i in (0..size-1) do 
        towns_names_array << urls_array[i].gsub(".html","").capitalize
    end
    return towns_names_array
end

# get one email
def townhall_email(url)
    @page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{url}"))
    email = @page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]')
    return email.text
end 

# stack all the emails in an array 
def townhall_email_array
    urls = townhalls_urls
    size = urls.size
    emails_array = []
    for i in (0..size-1) do
        emails_array << townhall_email(urls[i])
    end 
    return emails_array
end 

#final result 
def result
    names = towns_names
    emails = townhall_email_array
    result = []

    result_hash = names.map.with_index do |name, index|
        new_hash = {}
        new_hash[name] = emails[index]
        new_hash
    end

    result_hash.each do |hash|
        result << hash
        puts hash
    end

end

result


