describe TextUtil do
  include TextUtil
  context "match_or_throw" do
    match_type = "TestMatch"
    str = "Hello World"
    it 'should get first match' do
      regex = /\b(Hello).*/
      expect(match_or_throw match_type, str, regex, 1).to match 'Hello'
    end
    it 'should raise RegexError' do
      regex = /\b(Howdy).*/
      expect { match_or_throw(match_type, str, regex, 1) }.to raise_error(RegexpError)
    end
    it 'should handle multiple matches' do
      regex = /\b(H).*(W.*)/
      expect(match_or_throw match_type, str, regex, 2).to match 'World'
    end
  end
end
