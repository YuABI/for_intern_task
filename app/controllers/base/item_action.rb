module Base
  module ItemAction
    extend ActiveSupport::Concern
    included do
    end

    def item_lists(tmp_items=nil)
      # @items = Item.alive_records.target_yyyymm(yyyymm: @target_yyyymm).where(company_id: @target_company.id)
      @items = tmp_items
      unless @items
        @items = Item.alive_records#.where(company_id: @current_company.id)
      end
      @query = params[:query]
      unless @query.blank?
        words = [
          @query,
          Moji.zen_to_han(@query),
          Moji.han_to_zen(@query),
          Moji.kata_to_hira(@query),
          @query.tr('ぁ-ん','ァ-ン')
        ].compact.uniq
        @items = @items.
          where("(
          #{words.map{|i| " name like '%#{i}%' "}.join(" or ")}
          or
          #{words.map{|i| " short_name like '%#{i}%' "}.join(" or ")}
          or
          #{words.map{|i| " item_group_id in (select id from  item_groups where name like '%#{i}%')"}.join(" or ")}
          or
          #{words.map{|i| " item_group_id in (select id from  item_groups where short_name like '%#{i}%')"}.join(" or ")}
          or
          #{words.map{|i| " item_category_id in (select id from  item_categories where name like '%#{i}%')"}.join(" or ")}
          or
          #{words.map{|i| " item_category_id in (select id from  item_categories where code like '%#{i}%')"}.join(" or ")}
          or
          #{words.map{|i| " item_category_id in (select id from  item_categories where item_large_category_id in (select id from  item_large_categories where name like '%#{i}%'))"}.join(" or ")}
          or
          #{words.map{|i| " item_category_id in (select id from  item_categories where item_large_category_id in (select id from  item_large_categories where code like '%#{i}%'))"}.join(" or ")}
        )")
      end

      puts @items.to_sql

      @items = @items.limit(10)

      @items = @items.order("item_category_id,short_name asc")

      @items.each do |item|
        @order.purchase_line_items.build(
          name:          item.name,
          item_id:       item.try(:id).to_i,
          unit_table_id: item.unit_table_id,
          price:         item.try(:price).to_i,
          delivery:      (@order.shop.delivery_? ? 1 : 0),
          qty:          nil,
          mode:          1,
          shop_id:      @order.shop.id,
          )
      end
    end


  end
end
