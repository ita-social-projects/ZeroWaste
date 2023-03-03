shared_examples "compare categories" do
  it "returns valid product" do
    expect(product_diaper.prices.first).to eq product_napkin.prices.first
    expect(product_diaper.prices.last).to eq product_napkin.prices.last
  end
end
