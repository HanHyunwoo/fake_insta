class Post < ActiveRecord::Base
  has_many :comments
  has_many :users

  #검증(model validation)
  validates :title, presence: {message: "제목을 입력해주세요."}
  validates :content, presence: {message: "내용을 입력해주세요."},
                    length: { maximum: 5,
                              too_long: "제목은 %{count} 이내로 입력해주세요"  } # #{count} 는 Post.count 갯수이다.
  #validates :content, presence: true



end
