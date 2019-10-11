require 'nokogiri'         
require 'open-uri'

def deputies_urls
    @page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
    deputies_urls_array = []
    @page.xpath('//td/a/@href').each do |url|
        deputies_urls_array << url.text
    end
    return deputies_urls_array
end

def deputies_names
    @page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
    deputies_names_array = []

    @page.xpath('//td/a/div/span[@class = "list_nom"]').each do |name|
        deputies_names_array << name.text
    end

    size = deputies_names_array.size 
    names_array = []
    names_hash = {
        "first_name" =>"",
        "last_name" => ""
    }
    
    for i in (0..size-1) do 
        names_hash["first_name"] = deputies_names_array[i].match(",").post_match.gsub(" ","")
        names_hash["last_name"] = deputies_names_array[i].match(",").pre_match.gsub("\n","").gsub(" ","")
        names_array[i] = names_hash
        puts names_array[i]
    end

    return names_array
end

def deputy_email(url)
    @page = Nokogiri::HTML(open("https://www.nosdeputes.fr#{url}"))
    email = @page.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]/a')
    return email.text
end


# stack all the emails in an array 
def deputies_email_array
    urls = deputies_urls
    size = urls.size
    emails_array = []
    for i in (0..size-1) do
        emails_array << deputy_email(urls[i])
        puts emails_array[i]
    end 
    return emails_array
end 

def result 
    names = deputies_names
    emails = deputies_email_array
    size = names.size 
    result= []

    for i in (0..size-1) do
        puts emails[i]
    end 

    #result_hash = names.map.with_index do |name, index|
    #    names[index]["email"] = emails[index]
    #end

    #result_hash.each do |hash|
    #    result << hash
    #    puts hash
    #end

end

deputies_names
deputies_email_array
