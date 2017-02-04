FactoryGirl.define do
  factory :game do
    rows 5
    cols 6
    mines 4
    state { "%" * (rows * cols) }
  end
end
