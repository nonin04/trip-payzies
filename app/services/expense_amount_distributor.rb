class ExpenseAmountDistributor

  def initialize(expense)
    @expense = expense
  end

  def call
    advance_payments = @expense.advance_payments.to_a
    total_amount = @expense.amount
    count = advance_payments.count
    if count == 0
      puts "---------cuontが0です---------"
      return 
    end

    #------------------------
    if total_amount < count
      puts "---------総額#{total_amount}では1人あたり最低1円ずつ配れないためスキップ------------"
      return
    end
    #------------------------
    
    # 一人あたりの額(均等分け)
    base_amount = total_amount / count
    # 残り
    remains_amount = total_amount - base_amount * count

    #------------------------
    puts "▶ 基本額: #{base_amount}, 余り: #{remains_amount}"
    #------------------------
    
    # 均等分けした額を対象者のamountに追加
    advance_payments.each do |ap|
      ap.amount = base_amount
      #------------------------
      puts " - : #{ap.participant.name}"
      if ap.amount <= 0
        puts "⚠ #{ap.participant.name} の支払い額が0以下です: #{ap.amount}////////////////"
      end
      #------------------------
    end

    if remains_amount > 0
    # 対象者からランダムで余りの負担者を選択[配列]
    selected_participant_index = (0...count).to_a.shuffle.take(remains_amount)
    
      # 選択された負担者のamountに余りを追加
      selected_participant_index.each do |sp|
        advance_payments[sp].amount += 1
        #------------------------
        puts " +1: #{advance_payments[sp].participant.name}"
        #------------------------

      end
    end



    advance_payments.each do |ap|
      ap.save!
    end
    puts "---------------------------------------"

  end
end