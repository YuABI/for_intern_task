module Front
  module PageHelper
    def show_day_alert_message(mode1, is_tuesday)
      if is_tuesday
        deadline_message(mode1, "本日", "本日17：00")
      else
        deadline_message(mode1, "明日火曜日", "火曜17：00")
      end
    end

    private

    def deadline_message(mode1, day, time)
      if mode1
        <<~MSG
        <p>
          #{day}は来週お届け分のご注文締切日です。<br/>
          #{time}までにご入力をお願いします。<br/>
          締切後の追加・変更につきましてはご用意出来ない場合もございますので、ご入力忘れの無いよう宜しくお願いします。
        </p>
      MSG
      else
        <<~MSG
        <p>
          #{day}は「12月25日（火）～1月12日（土）」の3週間分の発注締め切り日です。<br/>
          #{time}までにご入力をお願い致します。<br/>
          年末年始はメーカーお休みなどの都合により<br/>
          締切後の追加、変更につきましてはご用意できない場合もございますので、<br/>
          入力忘れの無いよう宜しくお願いします。
        </p>
      MSG
      end
    end
  end
end
