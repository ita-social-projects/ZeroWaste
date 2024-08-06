xml.instruct! :xml, version: "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:image" => "http://www.google.com/schemas/sitemap-image/1.1", "xmlns:video" => "http://www.google.com/schemas/sitemap-video/1.1" do
  I18n.with_locale(locale) do
    xml.url do
      xml.loc root_url
      xml.lastmod Time.now.iso8601
      xml.changefreq "monthly"
    end

    xml.url do
      xml.loc calculator_url
      xml.lastmod Time.now.iso8601
      xml.changefreq "weekly"
    end

    xml.url do
      xml.loc about_url
      xml.lastmod Time.now.iso8601
      xml.changefreq "yearly"
    end
  end
end
