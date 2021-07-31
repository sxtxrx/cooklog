FactoryBot.define do
  factory :ingredient do
    name { "小麦粉" }
    quantity { "100g" }
    association :dish
    trait :ingredients do
      ingredients_attributes {
                               [
                                 { name: "じゃがいも", quantity: "1個" },
                                 { name: "玉ねぎ", quantity: "2個" },
                                 { name: "ニンジン", quantity: "3個" },
                                 { name: "豚肉", quantity: "4個" },
                                 { name: "りんご", quantity: "5個" },
                                 { name: "カレールー", quantity: "6個" },
                                 { name: "隠し味", quantity: "7個" },
                                 { name: "だし", quantity: "8個" },
                                 { name: "ピーマン", quantity: "9個" },
                                 { name: "なす", quantity: "10個" },
                               ]
      }
    end
  end
end
