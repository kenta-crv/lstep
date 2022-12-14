class Call < ApplicationRecord
  belongs_to :customer#, foreign_key: :tel, primary_key: :tel
  belongs_to :admin, optional: true

  scope :times_last_call, -> {
    last_time = "SELECT sub_call.customer_id, MAX(sub_call.time) as last_time FROM calls as sub_call GROUP BY sub_call.customer_id";
    joins(
      "INNER JOIN (#{last_time}) AS sub ON sub.customer_id = calls.customer_id AND sub.last_time = calls.time"
    ).group(:customer_id)
  }

  scope :joins_last_call, -> {
    last_created_at = "SELECT sub_call.customer_id, MAX(sub_call.created_at) as last_created_at FROM calls as sub_call GROUP BY sub_call.customer_id";
    joins(
      "INNER JOIN (#{last_created_at}) AS sub ON sub.customer_id = calls.customer_id AND sub.last_created_at = calls.created_at"
    ).group(:customer_id)
  }

  @@StatuItems = [
  "日程調整中",
  "着信留守",
  "担当者不在",
  "見込高",
  "見込中",
  "見込低",
  "契約",
  "NG",
  "回答待ち",
]
def self.StatuItems
  @@StatuItems
end


end
