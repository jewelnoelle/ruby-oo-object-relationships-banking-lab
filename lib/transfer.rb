class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if valid? && sender.balance > self.amount && self.status == "pending"
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    elsif sender.balance == sender.balance - self.amount
      self.status = "complete"
    else #come back to; why is it showing "complete"?
# sender.balance < self.amount || sender.status == "closed" || receiver.status == "closed"
    transfer_denied 
    end
  end

  def transfer_denied
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if valid? && self.status == "complete"
      sender.balance = sender.balance + self.amount
      receiver.balance = receiver.balance - self.amount
      self.status = "reversed"
    elsif sender.balance == sender.balance + self.amount
      self.status = "reversed"
    end
  end

end
