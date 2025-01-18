require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#sanitized_notes" do
    let(:valid_html) do
      '<p class="text-bold">This is <strong>bold</strong> and <em>italic</em>. <a href="http://example.com" target="_blank">Link</a></p>'
    end

    let(:invalid_html) do
      '<script>alert("XSS")</script><p>This is safe content</p>'
    end

    let(:mixed_html) do
      '<p>This is <strong>bold</strong> and <script>alert("XSS")</script> <a href="http://example.com">Link</a></p>'
    end

    it "allows specific tags and attributes" do
      result = helper.sanitized_notes(valid_html)
      expect(result).to include('<p class="text-bold">')
      expect(result).to include('<strong>bold</strong>')
      expect(result).to include('<em>italic</em>')
      expect(result).to include('<a href="http://example.com" target="_blank">Link</a>')
    end

    it "removes disallowed tags" do
      result = helper.sanitized_notes(invalid_html)
      expect(result).not_to include('<script>')
    end

    it "removes disallowed tags but keeps allowed tags and attributes" do
      result = helper.sanitized_notes(mixed_html)
      expect(result).to include('<p>This is <strong>bold</strong>')
      expect(result).not_to include('<script>')
      expect(result).to include('<a href="http://example.com">Link</a>')
    end

    it "does not remove allowed attributes from tags" do
      html_with_attributes = '<img src="image.png" alt="example image" style="width:100px;">'
      result = helper.sanitized_notes(html_with_attributes)
      expect(result).to eq('<img src="image.png" alt="example image" style="width:100px;">')
    end
  end
end
