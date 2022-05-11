require 'rails_helper'

RSpec.describe Note, type: :model do
  # ファクトリで関連するデータを生成する
  it "generates associated data from a factory" do
    note = FactoryBot.create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  # このファイルの全テストで使用するテストデータをセットアップする
  before do
    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@exmaple.com",
      password: "password"
    )

    @project = @user.projects.create(
      name: "Test Project",
    )
  end

  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること 
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note.",
      user: @user,
      project: @project,
    )
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  # 検索に関するspecをまとめる
  describe "search message for a term" do

    # 検索機能の全テストに関連するテストデータのセットアップを行う
    before do
      @note1 = @project.notes.create(
        message: "This is the first note",
        user: @user,
      )
      @note2 = @project.notes.create(
        message: "This is the second note",
        user: @user,
      )
      @note3 = @project.notes.create(
        message: "First, prehet the oven",
        user: @user,
      )
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    context "when a match is not found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty 
      end
    end
  end
end
