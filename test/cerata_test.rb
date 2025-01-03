
#
# testing cerata
#
# Tue Dec 31 15:56:48 JST 2024

require 'cerata'


group 'cerata' do

  group '.horizontal_a_to_s' do
  end

  group '.horizontal_h_to_s' do
  end

  group '.vertical_h_to_s' do
  end

  group '.table_to_s' do

    test 'format array of hashes' do

      ah = [
        { name: 'Haddock', fun: 'Captain', age: 52 },
        { name: 'Tintin', fun: 'Reporter', age: 31, weight: 60 },
        { name: 'Castafiore', id: 123, fun: 'Diva', age: 59, height: 163 },
        { name: 'Milou', id: 12, fun: 'Dog', age: 3, height: 20 } ]
      ahs = Cerata.table_to_s(ah)

      # test representation

      assert_equal(
        ahs,
        %{
[
{ name: "Haddock"   , fun: "Captain" , age: 52,                                  },
{ name: "Tintin"    , fun: "Reporter", age: 31, weight: 60,                      },
{ name: "Castafiore", fun: "Diva"    , age: 59,             id: 123, height: 163 },
{ name: "Milou"     , fun: "Dog"     , age:  3,             id:  12, height:  20 },
]
        }.strip)

      # test readability of representation

      ah1 = Kernel.eval(ahs)

      assert_equal(
        ah1,
        [{:name=>"Haddock", :fun=>"Captain", :age=>52},
         {:name=>"Tintin", :fun=>"Reporter", :age=>31, :weight=>60},
         {:name=>"Castafiore", :fun=>"Diva", :age=>59, :id=>123, :height=>163},
         {:name=>"Milou", :fun=>"Dog", :age=>3, :id=>12, :height=>20}])
    end

    _test 'formats ok with Kanji' do

      ah = [
        { name: 'Haddock', fun: '船長', age: 52 },
        { name: 'ティンティン', fun: 'Reporter', age: 31, weight: 60 } ]
      ahs = Cerata.table_to_s(ah)
puts ahs
    end
  end

  group '.term_length' do

    { '' => 0,
      '012345' => 6,
      '定石 b' => 6,

    }.each do |k, v|

      _test "returns #{v} for #{k.inspect}" do

        assert_equal Cerata.term_length(k), v
      end
    end
  end
end

