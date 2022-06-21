require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 姓、名、メール、バスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること for check user model validation
  it "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    # expect(user.errors[:first_name]).to_not include("can't be blank")
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # マールアドレスがなければ無効な状態であること
  it "is invalid without a email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "tester@example.com")
    user = FactoryBot.build(:user, email: "tester@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    # user = FactoryBot.build(:user)
    expect(user.name).to eq "John Doe"
  end
end
