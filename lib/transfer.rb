class Transfer
  
  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status= "pending"
    @amount = amount
  end
    
  def valid?
    sender.valid? && receiver.valid?
  end
    
  def execute_transaction
    if @sender.balance > @amount
      if valid? && self.status == "pending"
        @sender.balance -= @amount
        @receiver.balance += @amount
        self.status = "complete"
      end
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    self.status = "complete"
    @receiver.balance -= @amount
    @sender.balance += @amount
    @status = "reversed"
  end
end
