class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  has_many :likes
  #has_many :users, through :likes #likes라는 테이블을 통해서 많은 users들을 가지고 있다
  has_many :liked_users, through: :likes, source: :user #likes라는 테이블을 통해서 많은 좋아요를 한 유저들을 가지고 있다.
  mount_uploader :img, ImgUploader

  #검증(model validation)
  validates :title, presence: {message: "제목을 입력해주세요."},
                    length: {maximum: 30,
                            too_long: "제목은 %{count}자 이내로 입력해주세요." } #{count} 는 Post.count 갯수이다.
  validates :content, presence: {message: "내용을 입력해주세요."}
  #validates :content, presence: true



end
