class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course

  after_create :serial_generator 
  include AASM

  aasm column: "state" do #default column is not state
    state :pending, initial: true
    state :paid, :cancelled, :refunded 

    event :pay do
      transitions from: :pending, to: :paid

      after do
        update(paid_at: Time.current)
      end

    end

    event :cancel do
      transitions from: [:pending, :paid], to: :cancelled
    end

    event :refund do
      transitions from: [:paid, :cancelled], to: :refunded 
    end
  end

  private
  def serial_generator
    #self.serial --> serial(可省略self不打）
    #serial = "NFT#{Time.current.strftime("%y%m%d")}#{self.id.to_s.rjust(7, "0")}"
    #update(serial: serial)
    serial = "NFT#{Time.current.strftime("%Y%m%d")}#{code_generator(7)}"
    update(serial: serial)
  end

  def code_generator(n = 7)
    all_chars = [*"A".."Z","0".."9"]
    confused_chars = ['X', 'O', '0', 'B', 'P', 'M', 'N', 'D', 'T']
    (all_chars - confused_chars).sample(n).join
  end

end
