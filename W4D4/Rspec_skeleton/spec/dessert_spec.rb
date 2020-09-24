require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Antonio") }
  let(:gelato) { Dessert.new("gelato", 2, chef) }

  describe "#initialize" do
    it "sets a type" do 
       expect(gelato.type).to eq ("gelato")
    end

    it "sets a quantity" do 
      expect(gelato.quantity).to eq (2)
    end

    it "starts ingredients as an empty array" do
    expect(gelato.ingredients).to eq ([])
    end

    it "raises an argument error when given a non-integer quantity" do 
      expect { Dessert.new("gelato", "kg", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      gelato.add_ingredient("banana")
      expect(gelato.ingredients).to include("banana")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      ingredients = ["chocolate", "flour", "egg", "sugar", "butter"]
      gelato.mix!
      expect(gelato.ingredients).not_to eq(ingredients)
  end
   
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      gelato.eat(1)
      expect(gelato.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do 
      expect { gelato.eat(10)}.to raise_error("not enough left!")
    end

  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Antonio the Great Baker")
      expect(gelato.serve).to eq("Chef Antonio the Great Baker has made 2 gelatos!")

    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(gelato)
      gelato.make_more

    end
  end
end
