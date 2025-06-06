require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#sanitize_content" do
    let(:valid_html) do
      '<p class="text-bold">This is <strong>bold</strong> and <em>italic</em>. <a href="http://example.com" target="_blank">Link</a></p>'
    end

    let(:invalid_html) do
      '<script>alert("XSS")</script><p>This is safe content</p>'
    end

    let(:mixed_html) do
      '<p>This is <strong>bold</strong> and <script>alert("XSS")</script> <a href="http://example.com">Link</a></p>'
    end

    let(:html_with_attributes) do
      '<img src="image.png" alt="example image" style="width:100px;">'
    end

    it "allows specific tags and attributes" do
      expect(helper.sanitize_content(valid_html)).to include('<p class="text-bold">')
      expect(helper.sanitize_content(valid_html)).to include("<strong>bold</strong>")
      expect(helper.sanitize_content(valid_html)).to include("<em>italic</em>")
      expect(helper.sanitize_content(valid_html)).to include('<a href="http://example.com" target="_blank">Link</a>')
    end

    it "removes disallowed tags" do
      expect(helper.sanitize_content(invalid_html)).not_to include("<script>")
    end

    it "removes disallowed tags but keeps allowed tags and attributes" do
      expect(helper.sanitize_content(mixed_html)).to include("<p>This is <strong>bold</strong>")
      expect(helper.sanitize_content(mixed_html)).not_to include("<script>")
      expect(helper.sanitize_content(mixed_html)).to include('<a href="http://example.com">Link</a>')
    end

    it "does not remove allowed attributes from tags" do
      expect(helper.sanitize_content(html_with_attributes)).to eq('<img src="image.png" alt="example image" style="width:100px;">')
    end
  end
end
