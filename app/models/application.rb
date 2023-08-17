class Application < ApplicationRecord
  belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'
  belongs_to :recruitment
  validates_uniqueness_of :recruitment_id, scope: :applicant_id
  # 募集と申込者（applicant)の同じ組み合わせが2つ以上登録されないようにするため、このようなバリデーションを記述

  validates :message, length: { in: 0..150 }
end
