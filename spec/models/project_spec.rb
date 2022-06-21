require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = User.create(
      first_name: "cho",
      last_name: "oo",
      email: "tester@example.com",
      password: 'secret1234'
    )
  end

  it "is valid with owner, name" do
    project = Project.new(
      name: "Test Project",
      owner: @user
    )
    expect(project).to be_valid
  end

  it "is invalid without name" do
    project = Project.new(
      name: nil
    )
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  describe "late status" do
    it "is late when the due date is past today" do
      # project = FactoryBot.create(:project_due_yesterday)
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      # project = FactoryBot.create(:project_due_today)
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end
    
    it "is on time when the due date is in the future" do
      # project = FactoryBot.create(:project_due_tomorrow)
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    @user.projects.create(
      name: "Test Project"
    )

    new_project = @user.projects.build(
      name: "Test Project"
    )
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end
  # 二人のユーザーが同じ名前を使うことは許可すること
  it "allows two users to share a project name" do
    @user.projects.create(
      name: "Test Project"
    )

    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "jane@example.com",
      password: "PAssWorD"
    )
    other_project = other_user.projects.create(
      name: "Test Project"
    )
    expect(other_project).to be_valid
  end
end
