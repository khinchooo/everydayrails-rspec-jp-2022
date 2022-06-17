require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # 姓、名、メール、バスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: "khin",
      last_name: "cho oo",
      email: "khinchooo@gmail.com",
      password: "secret1234"
    )
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること for check user model validation
  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    # expect(user.errors[:first_name]).to_not include("can't be blank")
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # マールアドレスがなければ無効な状態であること
  it "is invalid without a email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      first_name: "cho",
      last_name: "oo",
      email: "tester@example.com",
      password: 'secret1234'
    )
    user = User.new(
      first_name: "khin",
      last_name: "cho oo",
      email: "tester@example.com",
      password: "secret5678"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = User.new(
      first_name: "khin",
      last_name: "cho oo",
      email: "khinchooo@gmail.com",
      password: "secret1234"
    )
    expect(user.name).to eq "khin cho oo"
  end
end
