class User < ApplicationRecord
  # バリデーション　不正なデータが登録されないようにチェックする
  # nameの値が未入力の場合、表示するメッセージ
  validates :name,
  presence: {message: "名前を入力してください。"}
end
